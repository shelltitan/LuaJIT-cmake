# This toolchain is assumes it is being used on a Windows machine targeting Windows, and used with ninja for buildsystem generation.
# The toolchain also selects the latest available Visual Studio toolchain, which confusingly means the latest updated or installed.
# CMAKE_SYSTEM_PROCESSOR The processor to compiler for. One of 'X86', 'AMD64', 'ARM64'. Defaults to ${CMAKE_HOST_SYSTEM_PROCESSOR}.
cmake_minimum_required(VERSION 3.26)
include_guard(GLOBAL)

## Host architecture and system
# Host system must be Windows
if(NOT (CMAKE_HOST_SYSTEM_NAME STREQUAL Windows))
    return()
endif()

# Host arch for MSVC host tools
# Windows 11 does not have 32 bit system
if(NOT DEFINED CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE)
    if(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL ARM64)
        set(CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE "ARM64")
    else()
        set(CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE "x64")
    endif()
endif()

## Target triplet (CPU family/model, vendor, and OS name)
if (NOT DEFINED CMAKE_SYSTEM_PROCESSOR)
    set(CMAKE_SYSTEM_PROCESSOR "${CMAKE_HOST_SYSTEM_PROCESSOR}")
endif()

# If `CMAKE_SYSTEM_PROCESSOR` is not equal to `CMAKE_HOST_SYSTEM_PROCESSOR`, this is cross-compilation.
# CMake expects `CMAKE_SYSTEM_NAME` to be set to reflect cross-compilation.
if(NOT (CMAKE_SYSTEM_PROCESSOR STREQUAL "${CMAKE_HOST_SYSTEM_PROCESSOR}"))
    set(CMAKE_SYSTEM_NAME "${CMAKE_HOST_SYSTEM_NAME}")
    set(CMAKE_SYSTEM_VERSION "${CMAKE_HOST_SYSTEM_VERSION}")
endif()

# Map processor to VS platform name
if (NOT DEFINED CMAKE_VS_PLATFORM_NAME)
    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64")
        set(CMAKE_VS_PLATFORM_NAME "x64")
        set(DASC "vm_x64.dasc")
        set()
    elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "ARM64")
        set(CMAKE_VS_PLATFORM_NAME "ARM64")
        set()
    else()
        message(FATAL_ERROR "Unable identify compiler architecture for CMAKE_SYSTEM_PROCESSOR ${CMAKE_SYSTEM_PROCESSOR} ${CMAKE_HOST_SYSTEM_PROCESSOR}")
    endif()
endif()

# General compile flags
#@set /nologo /c /O2 /W3 /D_CRT_SECURE_NO_DEPRECATE /D_CRT_STDIO_INLINE=__declspec(dllexport)__inline
#for lib archiver /nologo /nodefaultlib