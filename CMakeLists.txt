cmake_minimum_required(
	VERSION 4.0.0 
	FATAL_ERROR
)

project(
	luajit 
	LANGUAGES C
	VERSION 2.1.0
)

include(GNUInstallDirs)

option(LUAJIT_DISABLE_GC64 "Disable LJ_GC64 mode for x64" OFF)
option(LUAJIT_LUA52COMPATIBLE "Enable extra Lua 5.2 extensions" OFF)
#@rem   amalg         amalgamated build
#@rem   static        create static lib to statically link into your project
#@rem   mixed         create static lib to build a DLL in your project
#@rem Add more debug flags here, e.g. DEBUGCFLAGS=/DLUA_USE_ASSERT
#@set DEBUGCFLAGS=
#@set LJCOMPILE=cl /nologo /c /O2 /W3 /D_CRT_SECURE_NO_DEPRECATE /D_CRT_STDIO_INLINE=__declspec(dllexport)__inline
#@set LJDYNBUILD=/DLUA_BUILD_AS_DLL /MD
#@set LJDYNBUILD_DEBUG=/DLUA_BUILD_AS_DLL /MDd 
#@set LJCOMPILETARGET=/Zi
#@set LJLINKTYPE=/DEBUG /RELEASE
#@set LJLINKTYPE_DEBUG=/DEBUG
#@set LJLINKTARGET=/OPT:REF /OPT:ICF /INCREMENTAL:NO
#@set LJLINK=link /nologo
#@set LJMT=mt /nologo
#@set LJLIB=lib /nologo /nodefaultlib
#@set DASMDIR=..\dynasm
#@set DASM=%DASMDIR%\dynasm.lua
#@set DASC=vm_x64.dasc
#@set LJDLLNAME=lua51.dll
#@set LJLIBNAME=lua51.lib
#@set ALL_LIB=lib_base.c lib_math.c lib_bit.c lib_string.c lib_table.c lib_io.c lib_os.c lib_package.c lib_debug.c lib_jit.c lib_ffi.c lib_buffer.c
# we will debug         emit debug symbols


set(
    Header_Files
)

source_group(
	TREE "${CMAKE_CURRENT_SOURCE_DIR}/libsodium/src/libsodium" 
	PREFIX "Header Files" 
	FILES ${Header_Files}
)

set(
    Source_Files
)

source_group(
    TREE "${CMAKE_CURRENT_SOURCE_DIR}/libsodium/src/libsodium" 
    PREFIX "Source Files" 
    FILES ${Source_Files}
)

set(
    ALL_FILES
    ${Header_Files}
    ${Source_Files}
)

add_library(
    ${PROJECT_NAME} 
    ${ALL_FILES}
)