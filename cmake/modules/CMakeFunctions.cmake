#
# Set compiler RTTI options according to the given flag
#
macro(use_rtti val)
    if( CMAKE_COMPILER_IS_GNUCXX OR "${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
        if( ${val} )
            llvm_replace_compiler_option(CMAKE_CXX_FLAGS "-fno-rtti" "-frtti")
        else()
            llvm_replace_compiler_option(CMAKE_CXX_FLAGS "-frtti" "-fno-rtti" )
        endif()
    else(MSVC)
        if( ${val} )
            llvm_replace_compiler_option(CMAKE_CXX_FLAGS "/GR-" "/GR")
        else()
            llvm_replace_compiler_option(CMAKE_CXX_FLAGS "/GR" "/GR-" )
        endif()
    endif()
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" PARENT_SCOPE )
endmacro(use_rtti)

#
# Set compiler Exception Handling options according to the given flag
#
macro(use_eh val)
    if( CMAKE_COMPILER_IS_GNUCXX OR "${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
        if( ${val} )
            remove_definitions( -fno-exceptions )
        else()
            add_definitions( -fno-exceptions )
        endif()
    else(MSVC)
        if( ${val} )
              llvm_replace_compiler_option(CMAKE_CXX_FLAGS "/EHs-c-" "/EHsc" )
              add_definitions( /D_HAS_EXCEPTIONS=1 )
        else()
              llvm_replace_compiler_option(CMAKE_CXX_FLAGS "/EHsc" "/EHs-c-")
              add_definitions( /D_HAS_EXCEPTIONS=0 )
        endif()
    endif()
endmacro(use_eh)

# Reads hash-commit from backported patch
# This function assumes that each of files starts with (for example):
# From 1a400928bf8fc86fa0f062524c25d0985c94ac6f Mon Sep 17 00:00:00 2001
function(get_backport_patch_hash patch_path patch_hash)
    file(READ ${patch_path} first_line LIMIT 40 OFFSET 5)
    string(STRIP ${first_line} first_line_strip)
    set(patch_hash ${first_line_strip} PARENT_SCOPE)
endfunction()

# Checks if the the patch is present in current local branch
function(is_backport_patch_present patch_path repo_dir patch_in_branch)
    get_backport_patch_hash(${patch_path} patch_hash)
    message(STATUS "[OPENCL-CLANG] Checking if patch ${patch_hash} is present in repository")
    execute_process(
        COMMAND ${GIT_EXECUTABLE} merge-base --is-ancestor ${patch_hash} HEAD
        WORKING_DIRECTORY ${repo_dir}
        RESULT_VARIABLE patch_not_in_branches
        OUTPUT_QUIET
        )
    if(patch_not_in_branches)
        set(patch_in_branch False PARENT_SCOPE) # The patch is not present in local branch
    else()
        set(patch_in_branch True PARENT_SCOPE)  # The patch is not present in local branch
    endif()
endfunction()

# Validates if given SHA1/tag/branch name exists in local repo
function(is_valid_revision repo_dir revision return_val)
    message(STATUS "[OPENCL-CLANG] Validating ${revision} in repository")
    # Check if we have under revision existing branch/tag/SHA1 in this repo
    execute_process(
        COMMAND ${GIT_EXECUTABLE} log -1 ${revision}
        WORKING_DIRECTORY ${repo_dir}
        RESULT_VARIABLE output_var
        OUTPUT_QUIET
        )
    if(${output_var} EQUAL 0)
        set(${return_val} True PARENT_SCOPE) # this tag/branch/sha1 exists in repo
    else()
        set(${return_val} False PARENT_SCOPE) # this tag/branch/sha1 not exists in repo
    endif()
endfunction()

#
# Creates `target_branch` starting at the `base_revision` in the `repo_dir`.
# Then all patches from the `patches_dir` are committed to the `target_branch`.
# Does nothing if the `target_branch` is already checked out in the `repo_dir`.
#
function(apply_patches repo_dir patches_dir base_revision target_branch ret)
    foreach(patches_dir ${patches_dir})
        file(GLOB patches_in_dir ${patches_dir}/*.patch)
        list(APPEND patches ${patches_in_dir})
    endforeach()
    if(NOT patches)
        message(STATUS "[OPENCL-CLANG] No patches in ${patches_dir}")
        return()
    endif()

    message(STATUS "[OPENCL-CLANG] Patching repository ${repo_dir}")
    # Check if the target branch already exists
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse --verify --no-revs -q ${target_branch}
        WORKING_DIRECTORY ${repo_dir}
        RESULT_VARIABLE patches_needed
        OUTPUT_QUIET
    )
    if(patches_needed EQUAL 128) # not a git repo
        set(ret_not_git_repo 1)
	elseif(patches_needed) # The target branch doesn't exist
        list(SORT patches)
        is_valid_revision(${repo_dir} ${base_revision} exists_base_rev)

        if(NOT ${exists_base_rev})
            execute_process( # take SHA1 from HEAD
                COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
                WORKING_DIRECTORY ${repo_dir}
                OUTPUT_VARIABLE repo_head
                OUTPUT_STRIP_TRAILING_WHITESPACE
                )
            message(STATUS "[OPENCL-CLANG] ref ${base_revision} not exists in repository, using current HEAD:${repo_head}")
            set(base_revision ${repo_head})
        endif()
        execute_process( # Create the target branch
            COMMAND ${GIT_EXECUTABLE} checkout -b ${target_branch} ${base_revision}
            WORKING_DIRECTORY ${repo_dir}
            RESULT_VARIABLE ret_check_out
            ERROR_STRIP_TRAILING_WHITESPACE
            ERROR_VARIABLE checkout_log
            OUTPUT_QUIET
            )
        message(STATUS "[OPENCL-CLANG] ${checkout_log} which starts from ref : ${base_revision}")
        foreach(patch ${patches})
            is_backport_patch_present(${patch} ${repo_dir} patch_in_branch)
            if(${patch_in_branch})
                message(STATUS "[OPENCL-CLANG] Patch ${patch} is already in local branch - ignore patching")
            else()
                execute_process( # Apply the patch
                    COMMAND ${GIT_EXECUTABLE} am --3way --ignore-whitespace -C0 ${patch}
                    WORKING_DIRECTORY ${repo_dir}
                    OUTPUT_VARIABLE patching_log
                    RESULT_VARIABLE ret_apply_patch
                )
                message(STATUS "[OPENCL-CLANG] Not present - ${patching_log}")
                if (ret_apply_patch)
                    break()
                endif()
            endif()
        endforeach(patch)
    else() # The target branch already exists
        execute_process( # Check it out
            COMMAND ${GIT_EXECUTABLE} checkout ${target_branch}
            WORKING_DIRECTORY ${repo_dir}
            OUTPUT_QUIET
            RESULT_VARIABLE ret_check_out
        )
    endif()
	if (NOT (ret_not_git_repo OR ret_check_out OR ret_apply_patch))
        set(${ret} True PARENT_SCOPE)
    else()
        message(FATAL_ERROR "[OPENCL-CLANG] Failed to apply patch!")
    endif()
endfunction()

# Usage
#     SET_LINUX_EXPORTS_FILE( TARGET FILE_NAME )
# This function provides special linkage options for OCL Back-End. These options
# prevents exposure of function symbols externally (except functions which are
# explicitly listed in version script)
function ( SET_LINUX_EXPORTS_FILE TARGET FILE_NAME )
    if(NOT WIN32)
        get_target_property( SOURCE_FILES ${TARGET_NAME} SOURCES )
        list( GET SOURCE_FILES 0 FIRST_SOURCE )
        set_source_files_properties( ${FIRST_SOURCE} PROPERTIES OBJECT_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${FILE_NAME} )
        set_property( TARGET ${TARGET_NAME} APPEND_STRING PROPERTY
                        LINK_FLAGS " -Wl,-Bsymbolic -Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/${FILE_NAME}" )
    endif(NOT WIN32)
endfunction ( SET_LINUX_EXPORTS_FILE )
