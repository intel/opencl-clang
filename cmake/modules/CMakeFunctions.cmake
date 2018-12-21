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

#
# Creates `target_branch` starting at the `base_revision` in the `repo_dir`.
# Then all patches from the `patches_dir` are committed to the `target_branch`.
# Does nothing if the `target_branch` is already checked out in the `repo_dir`.
#
function(apply_patches repo_dir patches_dir base_revision target_branch)
    file(GLOB patches ${patches_dir}/*.patch)
    if(NOT patches)
        return()
    endif()

    message(STATUS "${repo_dir}:")
    # Check if the target branch already exists
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse --verify --no-revs -q ${target_branch}
        WORKING_DIRECTORY ${repo_dir}
        RESULT_VARIABLE patches_needed
    )
    if(patches_needed) # The target branch doesn't exist
        list(SORT patches)
        execute_process( # Create the target branch
            COMMAND ${GIT_EXECUTABLE} checkout -b ${target_branch} ${base_revision}
            WORKING_DIRECTORY ${repo_dir}
        )
        execute_process( # Apply the pathces
            COMMAND ${GIT_EXECUTABLE} am --3way --ignore-whitespace ${patches}
            WORKING_DIRECTORY ${repo_dir}
        )
    else() # The target branch already exists
        execute_process( # Check it out
            COMMAND ${GIT_EXECUTABLE} checkout ${target_branch}
            WORKING_DIRECTORY ${repo_dir}
        )
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
