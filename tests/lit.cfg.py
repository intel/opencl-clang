"""
Lit configuration file for opencl-clang tests.
"""

import os

import lit.formats
from lit.llvm import llvm_config

config.name = "opencl-clang"

config.test_format = lit.formats.ShTest()

config.suffixes = [".cl", ".test"]

# Skip the Conformance folder to shorten CI run time on CPU-limited runner.
config.excludes = ["CMakeLists.txt", "Conformance"]

config.test_source_root = os.path.dirname(__file__)

config.test_exec_root = config.opencl_clang_obj_root

llvm_config.use_default_substitutions()

llvm_config.use_clang()

occ_cli = os.path.join(config.opencl_clang_tools_dir, "occ-cli")
cfg_path = os.path.join(config.opencl_clang_src_root, "tests", "occ-cli")
cl_device = getattr(config, "cl_device", "DEFAULT")

config.substitutions.extend(
    [
        ("%occ-cli", occ_cli),
        ("%cfg_path", "--config-path=" + cfg_path),
        ("%cl_device", cl_device),
    ]
)

if "PATH" in os.environ:
    config.environment["PATH"] = os.path.pathsep.join(
        [config.opencl_clang_tools_dir, os.environ["PATH"]]
    )
else:
    config.environment["PATH"] = config.opencl_clang_tools_dir

if "LD_LIBRARY_PATH" in os.environ:
    config.environment["LD_LIBRARY_PATH"] = os.path.pathsep.join(
        [config.llvm_libs_dir, os.environ["LD_LIBRARY_PATH"]]
    )
else:
    config.environment["LD_LIBRARY_PATH"] = config.llvm_libs_dir
