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
Common utilities for resource embedders.

This module provides shared functionality used by the resource embedders,
e.g. directory_resource_embedder.py.
"""

import re


class EmbedderBase:
    """Base class with common functionality for resource embedders."""

    def __init__(self):
        self._symRe = re.compile('^[a-zA-Z_][a-zA-Z0-9_]*$')
        self._lineSize = 20
        self._msvcChunkSize = 16380  # MSVC string literal limit

    def _checkIfTextFile(self, filePath):
        """Check if a file is a text file by attempting UTF-8 decode."""
        try:
            with open(filePath, 'r', encoding='utf-8') as f:
                content = f.read()
            return True, content
        except (UnicodeDecodeError, IOError):
            return False, None

    def _validateSymbolName(self, symName):
        """Validate that a symbol name is a valid C/C++ identifier."""
        if not self._symRe.match(symName) or symName.endswith('_size'):
            return False
        return True

    def _isCppFile(self, filePath):
        """Detect if output file is C++ based on extension."""
        return filePath.lower().endswith(('.cpp', '.cc', '.cxx', '.hpp', '.hxx'))

    def _getExternKeyword(self, isCpp):
        """Return 'extern "C"' for C++, empty string for C."""
        return 'extern "C" ' if isCpp else ''

    def _escapeCString(self, s):
        """Escape special characters in a C string literal."""
        s = s.replace('\\', '\\\\')
        s = s.replace('"', '\\"')
        s = s.replace('\n', '\\n')
        s = s.replace('\r', '\\r')
        s = s.replace('\t', '\\t')
        return s

    def _findRawStringDelimiter(self, content):
        """Find a delimiter that doesn't appear in the content for raw string literals."""
        delimiter = "===="
        while f'){delimiter}"' in content:
            delimiter += "="
        return delimiter

    def _splitOnLineBoundaries(self, content, maxChunkSize):
        """Split content into chunks on line boundaries, respecting max chunk size."""
        chunks = []
        lines = content.split('\n')
        currentChunk = []
        currentSize = 0

        for i, line in enumerate(lines):
            # Add newline back except for last line
            lineWithNewline = line + ('\n' if i < len(lines) - 1 else '')
            lineSize = len(lineWithNewline.encode('utf-8'))

            # If adding this line exceeds limit and we have content, save current chunk
            if currentSize + lineSize > maxChunkSize and currentChunk:
                chunks.append(''.join(currentChunk))
                currentChunk = []
                currentSize = 0

            currentChunk.append(lineWithNewline)
            currentSize += lineSize

        # Add remaining content
        if currentChunk:
            chunks.append(''.join(currentChunk))

        return chunks

    def _formatRawStringLiteral(self, content, msvcMode=False):
        """
        Format content as C++ raw string literal(s).
        Returns tuple: (opening, body, closing, size)
        - opening: array declaration start (e.g., "const unsigned char name[] = ")
        - body: the raw string literal content(s)
        - closing: array closing (e.g., ";\n\n")
        - size: byte size of the content
        """
        delimiter = self._findRawStringDelimiter(content)
        size = len(content.encode('utf-8'))

        if msvcMode:
            # Split content into chunks on line boundaries for MSVC
            chunks = self._splitOnLineBoundaries(content, self._msvcChunkSize)
            body_parts = []
            for i, chunk in enumerate(chunks):
                if i > 0:
                    body_parts.append('\n    ')
                body_parts.append('R"{0}({1}){0}"'.format(delimiter, chunk))
            body = ''.join(body_parts)
        else:
            # Single raw string literal
            body = 'R"{0}({1}){0}"'.format(delimiter, content)

        return ('', body, ';\n\n', size)

    def _formatHexByteArray(self, dataBytes, includeNullTerminator=True):
        """
        Format data as hex byte array.
        Returns tuple: (opening, body, closing, size)
        - opening: array declaration start (e.g., "const unsigned char name[] = {")
        - body: the hex bytes content
        - closing: array closing with terminator (e.g., ",\n  0x00 // Null terminator\n};\n\n")
        - size: byte size of the data
        """
        lineSize = self._lineSize
        embeddedSize = len(dataBytes)

        body_parts = []
        for i, byte in enumerate(dataBytes):
            if i > 0:
                body_parts.append(',')
            if i % lineSize == 0:
                body_parts.append('\n  ')
            else:
                body_parts.append(' ')
            body_parts.append('0x{0:02x}'.format(byte))

        body = ''.join(body_parts)

        if includeNullTerminator:
            if embeddedSize > 0:
                closing = ',\n  0x00 // Null terminator\n};\n\n'
            else:
                closing = '\n  0x00 // Null terminator\n};\n\n'
        else:
            closing = '\n};\n\n'

        return ('{', body, closing, embeddedSize)

    def _formatC23EmbedDirective(self, filePath):
        """
        Format C23 #embed directive.
        Returns tuple: (opening, body, closing, size)
        - opening: array declaration start (e.g., "const unsigned char name[] = {\n")
        - body: the #embed directive
        - closing: array closing (e.g., "  0x00 // Null terminator\n};\n\n")
        - size: file size
        """
        import os
        body = '#embed "{0}" suffix(,)\n'.format(filePath.replace('\\', '/'))
        closing = '  0x00 // Null terminator\n};\n\n'
        size = os.path.getsize(filePath)
        return ('{\n', body, closing, size)
