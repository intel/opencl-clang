"""
Lit configuration file for the opencl-clang unit tests.
"""

import os

import lit.formats

config.name = "opencl-clang-Unit"

# suffixes: A list of file extensions to treat as test files.
config.suffixes = []

# test_source_root: The root path where tests are located.
# test_exec_root: The root path where tests should be run.
config.test_exec_root = os.path.join(config.opencl_clang_obj_root, "unittests")
config.test_source_root = config.test_exec_root

# testFormat: The test format to use to interpret tests. Discovers and runs
# the compiled Google Test executables (e.g. OpenCLClangOptionsTests) that
# unittests/CMakeLists.txt places under the build tree's unittests/
# directory.
config.test_format = lit.formats.GoogleTest(config.llvm_build_mode, "Tests")
