#
# Copyright (c) Intel Corporation (2026).
#
# INTEL MAKES NO WARRANTY OF ANY KIND REGARDING THE CODE. THIS CODE IS
# LICENSED ON AN "AS IS" BASIS AND INTEL WILL NOT PROVIDE ANY SUPPORT,
# ASSISTANCE, INSTALLATION, TRAINING OR OTHER SERVICES. INTEL DOES NOT
# PROVIDE ANY UPDATES, ENHANCEMENTS OR EXTENSIONS. INTEL SPECIFICALLY
# DISCLAIMS ANY WARRANTY OF MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR ANY
# PARTICULAR PURPOSE, OR ANY OTHER WARRANTY. Intel disclaims all liability,
# including liability for infringement of any proprietary rights, relating to
# use of the code. No license, express or implied, by estoppel or otherwise,
# to any intellectual property rights is granted herein.
#

"""
Directory Resource Embedder - Embed multiple files from a directory as C/C++ arrays

This script embeds all files from a directory (recursively) into a single C/C++ output
file, generating multiple arrays for efficient access to individual files. Also generates
a header file with declarations compatible with both C and C++.

Features:
  - Recursive directory scanning with glob pattern filtering
  - Multiple embedding modes:
    * C23 #embed directive (--c23-embed) for compile-time inclusion
    * C++ raw string literals for text files (--raw-string)
    * Traditional hex byte arrays for binary files and C output
  - Incremental build support with timestamp and metadata checking
  - MSVC mode (--msvc) to split large string literals for MSVC compatibility
  - Automatic header file generation with C/C++ compatibility
  - Generated arrays:
    * Combined data array with all file contents (null-separated)
    * Array of relative file paths (null-terminated strings)
    * Array of byte offsets for each file in the data array
    * Array of sizes for each file
    * Count constant for number of files
  - Automatic language detection based on output file extension (.c/.cpp)
  - C++ output: Symbols wrapped in extern "C" for C linkage
  - C output: Plain C declarations

Output format (traditional mode):
  - Data array: const unsigned char <name>_data[]
  - Filenames array: const char* <name>_filenames[]
  - Offsets array: const unsigned int <name>_offsets[]
  - Sizes array: const unsigned int <name>_sizes[]
  - Count constant: const unsigned int <name>_count

Output format (C23 #embed mode):
  - Individual #embed directives for each file
  - Same array structure as traditional mode but using #embed

Example usage:
  python3 directory_resource_embedder.py /path/to/dir output.cpp resources "*.h"

  Generates output.cpp and output.h with embedded resource arrays for all .h files.

  With C23 #embed:
  python3 directory_resource_embedder.py /path/to/dir output.c resources "*.h" --c23-embed

  Generates output.c and output.h using C23 #embed directives:
    extern "C" {
      const unsigned char resources_data[] = {
        // File 0: header1.h
        #embed "path/to/header1.h" suffix(,)
        0x00,
        // File 1: header2.h
        #embed "path/to/header2.h" suffix(,)
        0x00
      };
      const char* resources_filenames[] = { "header1.h", "header2.h" };
      const unsigned int resources_offsets[] = { 0, 123 };
      const unsigned int resources_sizes[] = { 122, 456 };
      const unsigned int resources_count = 2;
    }
"""

import os
import sys
import fnmatch
import argparse
from pathlib import Path
from embedder_common import EmbedderBase


class DirectoryResEmb(EmbedderBase):
    def __init__(self, inDir, outFile, symName, filterPattern, useC23Embed=False, force=False, msvcMode=False, useRawString=None):
        super().__init__()
        self.__symName = symName
        self.__inDirPath = inDir
        self.__outFilePath = outFile
        self.__filterPattern = filterPattern
        self.__useC23Embed = useC23Embed
        self.__force = force
        self.__msvcMode = msvcMode
        self.__useRawString = useRawString  # None=auto, True=force, False=never for individual files
        self.__openedFiles = list()
        self.__files = []  # List of (relative_path, full_path) tuples
        self.__outFile = None
        self.__headerFile = None
        self.__needsRegeneration = True
        # Detect output language by file extension
        self.__isCpp = self._isCppFile(outFile)
        # Calculate header file path (replace extension with .h)
        outPath = Path(outFile)
        self.__headerFilePath = str(outPath.with_suffix('.h'))
        self.__validate()
        self.__scanDirectory()

        # Check if regeneration is needed
        if not self.__force and not self.__checkNeedsRegeneration():
            self.__needsRegeneration = False
            return

        try:
            self.__outFile = open(outFile, 'w')
        except EnvironmentError as ex:
            sys.stderr.write('ERROR: Cannot create/open output file "{0}".\n       {1}.\n'.format(outFile, ex.strerror))
            raise RuntimeError("failed to open output file")
        self.__openedFiles.append(self.__outFile)

        try:
            self.__headerFile = open(self.__headerFilePath, 'w')
        except EnvironmentError as ex:
            sys.stderr.write('ERROR: Cannot create/open header file "{0}".\n       {1}.\n'.format(self.__headerFilePath, ex.strerror))
            raise RuntimeError("failed to open header file")
        self.__openedFiles.append(self.__headerFile)

    def __del__(self):
        for openedFile in self.__openedFiles:
            openedFile.close()

    def __validate(self):
        if not self._validateSymbolName(self.__symName):
            sys.stderr.write('ERROR: Invalid symbol name "{0}".\n'.format(self.__symName))
            raise ValueError

        if not os.path.isdir(self.__inDirPath):
            sys.stderr.write('ERROR: Input path "{0}" is not a directory.\n'.format(self.__inDirPath))
            raise ValueError

    def __scanDirectory(self):
        """Recursively scan directory and collect files matching the filter pattern."""
        inDir = Path(self.__inDirPath)
        pattern = self.__filterPattern

        for root, dirs, files in os.walk(self.__inDirPath):
            root_path = Path(root)
            for filename in files:
                if fnmatch.fnmatch(filename, pattern):
                    full_path = root_path / filename
                    relative_path = full_path.relative_to(inDir)
                    self.__files.append((str(relative_path), str(full_path)))

        # Sort files for deterministic output
        self.__files.sort(key=lambda x: x[0])

        if not self.__files:
            sys.stderr.write('WARNING: No files found matching pattern "{0}" in directory "{1}".\n'.format(
                pattern, self.__inDirPath))

    def __checkNeedsRegeneration(self):
        """Check if output file needs regeneration based on source file timestamps."""
        # If output file or header file doesn't exist, regeneration is needed
        if not os.path.exists(self.__outFilePath) or not os.path.exists(self.__headerFilePath):
            return True

        # Check if file list or configuration has changed
        metadata = self.__parseMetadata(self.__headerFilePath)
        if metadata is None:
            # Can't parse metadata, regenerate to be safe
            return True

        # Compare base directory and filter pattern
        if metadata.get('base_dir') != os.path.abspath(self.__inDirPath) or metadata.get('filter') != self.__filterPattern:
            sys.stderr.write('Configuration changed, regenerating output files.\n')
            return True

        # Compare file list
        current_files = [rel_path for rel_path, _ in self.__files]
        if metadata.get('files') != current_files or metadata.get('count') != len(self.__files):
            sys.stderr.write('File list changed, regenerating output files.\n')
            return True

        try:
            output_mtime = os.path.getmtime(self.__outFilePath)
            header_mtime = os.path.getmtime(self.__headerFilePath)
            # Use the newer of the two output files
            output_mtime = max(output_mtime, header_mtime)
        except OSError:
            # If we can't get output file time, regenerate to be safe
            return True

        try:
            # If this script or its helper module has changed, we should regenerate
            script_mtime = os.path.getmtime(__file__)
            if script_mtime > output_mtime:
                return True
            common_module = os.path.join(os.path.dirname(__file__), 'embedder_common.py')
            if os.path.exists(common_module) and os.path.getmtime(common_module) > output_mtime:
                return True
        except OSError:
            # If we can't get script file time, regenerate to be safe
            return True

        # Check if any source file is newer than the output file
        for rel_path, full_path in self.__files:
            try:
                source_mtime = os.path.getmtime(full_path)
                if source_mtime > output_mtime:
                    return True
            except OSError:
                # If we can't get source file time, regenerate to be safe
                return True

        # All source files are older than output, no regeneration needed
        sys.stderr.write('Output files "{0}" and "{1}" are up to date, skipping regeneration.\n'.format(
            self.__outFilePath, self.__headerFilePath))
        return False

    def __generateMetadata(self):
        """Generate metadata string with current configuration and file list."""
        metadata_lines = []
        metadata_lines.append('// Metadata: DO NOT MODIFY')
        metadata_lines.append('// Base directory: {0}'.format(os.path.abspath(self.__inDirPath)))
        metadata_lines.append('// Filter pattern: {0}'.format(self.__filterPattern))
        metadata_lines.append('// File count: {0}'.format(len(self.__files)))
        metadata_lines.append('// Files:')
        for rel_path, _ in self.__files:
            metadata_lines.append('//   {0}'.format(rel_path))
        return '\n'.join(metadata_lines) + '\n'

    def __parseMetadata(self, filePath):
        """Parse metadata from existing output file."""
        try:
            with open(filePath, 'r') as f:
                metadata = {}
                files = []
                in_files_section = False
                in_metadata_section = False

                for line in f:
                    line = line.rstrip('\n')
                    if '// Metadata: DO NOT MODIFY' in line:
                        in_metadata_section = True
                        continue
                    elif not in_metadata_section:
                        continue
                    elif line.startswith('// Base directory: '):
                        metadata['base_dir'] = line.split('// Base directory: ', 1)[1]
                    elif line.startswith('// Filter pattern: '):
                        metadata['filter'] = line.split('// Filter pattern: ', 1)[1]
                    elif line.startswith('// File count: '):
                        metadata['count'] = int(line.split('// File count: ', 1)[1])
                    elif line.startswith('// Files:'):
                        in_files_section = True
                    elif in_files_section and line.startswith('//   '):
                        files.append(line.split('//   ', 1)[1])
                    elif line.strip() != '' and not line.startswith('//'):
                        break

                metadata['files'] = files
                return metadata
        except (IOError, ValueError):
            return None

    def __generateHeader(self):
        """Generate header file with C/C++ compatible declarations."""
        # Get header filename for include guard
        headerName = Path(self.__headerFilePath).name.upper().replace('.', '_').replace('-', '_')
        guardName = '{0}_'.format(headerName)

        # Write header guard and file header
        self.__headerFile.write('// This file is auto generated by directory_resource_embedder, DO NOT EDIT\n\n')

        # Write metadata for change detection
        self.__headerFile.write(self.__generateMetadata())
        self.__headerFile.write('\n')
        self.__headerFile.write('#ifndef {0}\n'.format(guardName))
        self.__headerFile.write('#define {0}\n\n'.format(guardName))

        # Add extern "C" wrapper with __cplusplus guard
        self.__headerFile.write('#ifdef __cplusplus\n')
        self.__headerFile.write('extern "C" {\n')
        self.__headerFile.write('#endif\n\n')

        # Write declarations
        symName = self.__symName

        if self.__files:
            self.__headerFile.write('// Number of embedded files\n')
            self.__headerFile.write('extern const unsigned int {0}_count;\n\n'.format(symName))

            self.__headerFile.write('// Combined data array (all files concatenated, null-terminated)\n')
            self.__headerFile.write('extern const unsigned char {0}_data[];\n\n'.format(symName))

            self.__headerFile.write('// Array of relative file paths\n')
            self.__headerFile.write('extern const char* {0}_filenames[];\n\n'.format(symName))

            self.__headerFile.write('// Array of byte offsets for each file in the data array\n')
            self.__headerFile.write('extern const unsigned int {0}_offsets[];\n\n'.format(symName))

            self.__headerFile.write('// Array of sizes for each file\n')
            self.__headerFile.write('extern const unsigned int {0}_sizes[];\n\n'.format(symName))
        else:
            # Empty arrays
            self.__headerFile.write('extern const unsigned int {0}_count;\n'.format(symName))
            self.__headerFile.write('extern const unsigned char {0}_data[];\n'.format(symName))
            self.__headerFile.write('extern const char* {0}_filenames[];\n'.format(symName))
            self.__headerFile.write('extern const unsigned int {0}_offsets[];\n'.format(symName))
            self.__headerFile.write('extern const unsigned int {0}_sizes[];\n\n'.format(symName))

        # Close extern "C" wrapper
        self.__headerFile.write('#ifdef __cplusplus\n')
        self.__headerFile.write('} // extern "C"\n')
        self.__headerFile.write('#endif\n\n')

        # Close header guard
        self.__headerFile.write('#endif // {0}\n'.format(guardName))

    def run(self):
        # Skip if regeneration is not needed
        if not self.__needsRegeneration:
            return

        # Generate header file
        self.__generateHeader()

        # Write common header
        self.__outFile.write('// This file is auto generated by directory_resource_embedder, DO NOT EDIT\n\n')
        self.__outFile.write('#include "{0}"\n\n'.format(Path(self.__headerFilePath).name))

        if self.__useC23Embed:
            self.__embedWithC23()
        else:
            self.__embedTraditional()

    def __embedWithC23(self):
        """Embed files using C23 #embed directive."""
        if not self.__files:
            # Generate empty arrays
            self.__writeEmptyArrays()
            return

        symName = self.__symName

        # Write count constant
        self.__outFile.write('const unsigned int {0}_count = {1};\n\n'.format(symName, len(self.__files)))

        # Write combined data array using #embed
        self.__outFile.write('const unsigned char {0}_data[] = {{\n'.format(symName))

        for i, (rel_path, full_path) in enumerate(self.__files):
            if i > 0:
                self.__outFile.write(',\n')
            # Escape backslashes for Windows paths in #embed
            escaped_path = full_path.replace('\\', '/')
            self.__outFile.write('  // File {0}: {1}\n'.format(i, rel_path))
            self.__outFile.write('  #embed "{0}" suffix(,)\n'.format(escaped_path))
            self.__outFile.write('  0x00')

        self.__outFile.write('\n};\n\n')

        # Write filenames array
        self.__outFile.write('const char* {0}_filenames[] = {{\n'.format(symName))
        for i, (rel_path, _) in enumerate(self.__files):
            self.__outFile.write('  "{0}"'.format(self.__escapeCString(rel_path)))
            if i < len(self.__files) - 1:
                self.__outFile.write(',')
            self.__outFile.write('\n')
        self.__outFile.write('};\n\n')

        # Calculate offsets and sizes by reading files
        offsets = []
        sizes = []
        current_offset = 0

        for rel_path, full_path in self.__files:
            offsets.append(current_offset)
            try:
                file_size = os.path.getsize(full_path)
            except OSError as ex:
                sys.stderr.write('ERROR: Cannot get size of file "{0}".\n       {1}.\n'.format(full_path, ex.strerror))
                raise RuntimeError("failed to get file size")
            sizes.append(file_size)
            current_offset += file_size + 1  # +1 for null terminator

        # Write offsets array
        self.__outFile.write('const unsigned int {0}_offsets[] = {{\n'.format(symName))
        for i, offset in enumerate(offsets):
            if i > 0:
                self.__outFile.write(',')
            if i % 10 == 0:
                self.__outFile.write('\n  ')
            else:
                self.__outFile.write(' ')
            self.__outFile.write('{0}'.format(offset))
        self.__outFile.write('\n};\n\n')

        # Write sizes array
        self.__outFile.write('const unsigned int {0}_sizes[] = {{\n'.format(symName))
        for i, size in enumerate(sizes):
            if i > 0:
                self.__outFile.write(',')
            if i % 10 == 0:
                self.__outFile.write('\n  ')
            else:
                self.__outFile.write(' ')
            self.__outFile.write('{0}'.format(size))
        self.__outFile.write('\n};\n\n')

    def __embedTraditional(self):
        """Embed files using traditional hex byte arrays or raw strings."""
        if not self.__files:
            # Generate empty arrays
            self.__writeEmptyArrays()
            return

        symName = self.__symName

        # Write count constant
        self.__outFile.write('const unsigned int {0}_count = {1};\n\n'.format(symName, len(self.__files)))

        # Determine if we should use raw strings for text files
        useRaw = self.__useRawString
        if useRaw is None:
            # Auto-detect: use raw strings for text files in C++
            useRaw = self.__isCpp
        elif useRaw and not self.__isCpp:
            sys.stderr.write('WARNING: Raw string literals require C++ output, using hex bytes instead.\n')
            useRaw = False

        # Collect all file contents and calculate offsets/sizes
        all_data = bytearray()
        offsets = []
        sizes = []
        file_contents = []  # Store text content for raw string mode

        for rel_path, full_path in self.__files:
            offsets.append(len(all_data))

            # Check if file is text
            isText = useRaw and self.__checkIfTextFile(full_path)

            try:
                if isText:
                    with open(full_path, 'r', encoding='utf-8') as f:
                        text_content = f.read()
                    file_data = text_content.encode('utf-8')
                    file_contents.append(('text', text_content))
                else:
                    with open(full_path, 'rb') as f:
                        file_data = f.read()
                    file_contents.append(('binary', file_data))
            except EnvironmentError as ex:
                sys.stderr.write('ERROR: Cannot open input file "{0}".\n       {1}.\n'.format(full_path, ex.strerror))
                raise RuntimeError("failed to open input file")

            sizes.append(len(file_data))
            all_data.extend(file_data)
            all_data.append(0)  # Null terminator

        # Write combined data array
        if useRaw and all(fc[0] == 'text' for fc in file_contents):
            # Use raw strings (only when all files are text)
            self.__embedTraditionalRawString(file_contents, symName)
        else:
            # Use hex bytes (always for binary or mixed content)
            self.__embedTraditionalHexBytes(all_data, symName)

        # Write offsets and sizes arrays
        self.__writeOffsetsAndSizes(offsets, sizes, symName)

    def __embedTraditionalHexBytes(self, all_data, symName):
        """Embed data as hex byte array."""
        self.__outFile.write('const unsigned char {0}_data[] = {{'.format(symName))

        lineSize = self._lineSize
        for i, byte in enumerate(all_data):
            if i > 0:
                self.__outFile.write(',')
            if i % lineSize == 0:
                self.__outFile.write('\n  ')
            else:
                self.__outFile.write(' ')
            self.__outFile.write('0x{0:02x}'.format(byte))

        self.__outFile.write('\n};\n\n')

    def __embedTraditionalRawString(self, file_contents, symName):
        """Embed data using raw string concatenation (all entries must be text)."""
        self.__outFile.write('const unsigned char {0}_data[] = \n'.format(symName))

        for i, (file_type, content) in enumerate(file_contents):
            content_str = content if isinstance(content, str) else content.decode('utf-8')
            opening, body, closing, size = self._formatRawStringLiteral(content_str, self.__msvcMode)

            if i > 0:
                self.__outFile.write('\n  ')
            self.__outFile.write(body)
            # Add null terminator between files
            self.__outFile.write('\n  "\\0"')

        self.__outFile.write(';\n\n')

    def __writeOffsetsAndSizes(self, offsets, sizes, symName):
        """Write offsets and sizes arrays."""
        # Write filenames array
        self.__outFile.write('const char* {0}_filenames[] = {{\n'.format(symName))
        for i, (rel_path, _) in enumerate(self.__files):
            self.__outFile.write('  "{0}"'.format(self.__escapeCString(rel_path)))
            if i < len(self.__files) - 1:
                self.__outFile.write(',')
            self.__outFile.write('\n')
        self.__outFile.write('};\n\n')

        # Write offsets array
        self.__outFile.write('const unsigned int {0}_offsets[] = {{\n'.format(symName))
        for i, offset in enumerate(offsets):
            if i > 0:
                self.__outFile.write(',')
            if i % 10 == 0:
                self.__outFile.write('\n  ')
            else:
                self.__outFile.write(' ')
            self.__outFile.write('{0}'.format(offset))
        self.__outFile.write('\n};\n\n')

        # Write sizes array
        self.__outFile.write('const unsigned int {0}_sizes[] = {{\n'.format(symName))
        for i, size in enumerate(sizes):
            if i > 0:
                self.__outFile.write(',')
            if i % 10 == 0:
                self.__outFile.write('\n  ')
            else:
                self.__outFile.write(' ')
            self.__outFile.write('{0}'.format(size))
        self.__outFile.write('\n};\n\n')

    def __writeEmptyArrays(self):
        """Write empty arrays when no files are found."""
        symName = self.__symName

        self.__outFile.write('const unsigned int {0}_count = 0;\n\n'.format(symName))
        self.__outFile.write('const unsigned char {0}_data[] = {{ 0x00 }};\n\n'.format(symName))
        self.__outFile.write('const char* {0}_filenames[] = {{ 0 }};\n\n'.format(symName))
        self.__outFile.write('const unsigned int {0}_offsets[] = {{ 0 }};\n\n'.format(symName))
        self.__outFile.write('const unsigned int {0}_sizes[] = {{ 0 }};\n\n'.format(symName))

    def __escapeCString(self, s):
        """Escape a string for C string literal."""
        return self._escapeCString(s)

    def __checkIfTextFile(self, filePath):
        """Check if a file is a text file."""
        isText, _ = self._checkIfTextFile(filePath)
        return isText


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Embed multiple files from a directory as C/C++ arrays"
    )

    parser.add_argument("input_directory",
                       help="Directory to scan for files")

    parser.add_argument("output_file",
                       help="Output C/C++ file path")

    parser.add_argument("symbol_name",
                       help="Base name for generated symbols")

    parser.add_argument("filter_pattern",
                       help='Glob pattern for file filtering (e.g., "*.h", "*")')

    parser.add_argument("--c23-embed", action="store_true", dest="c23_embed",
                       help="Use C23 #embed directive instead of traditional hex byte arrays")

    parser.add_argument("-f", "--force", action="store_true",
                       help="Force regeneration even if output file is up to date")

    parser.add_argument("--msvc", action="store_true",
                       help="Split text files into smaller string chunks to avoid MSVC error C2026 (string literal exceeds 16380 byte limit)")

    parser.add_argument("--raw-string", action="store_true", dest="raw_string",
                       help="Force use of raw string literals for text files (C++ only)")

    parser.add_argument("--no-raw-string", action="store_true", dest="no_raw_string",
                       help="Force use of hex byte arrays (disable raw string literals)")

    args = parser.parse_args()

    # Determine raw string mode
    useRawString = None
    if args.raw_string and args.no_raw_string:
        sys.stderr.write('ERROR: Cannot specify both --raw-string and --no-raw-string.\n')
        exit(1)
    elif args.raw_string:
        useRawString = True
    elif args.no_raw_string:
        useRawString = False

    try:
        embedder = DirectoryResEmb(
            args.input_directory, args.output_file, args.symbol_name.strip(), args.filter_pattern.strip(),
            useC23Embed=args.c23_embed, force=args.force, msvcMode=args.msvc, useRawString=useRawString
        )
        embedder.run()

    except Exception as ex:
        sys.stderr.write('ERROR: Embedder script error.\n       {0}.\n'.format(repr(ex)))
        exit(1)
