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
option(LUAJIT_STATIC "Create static lib to statically link into your project" OFF)
option(LUAJIT_MIXED "Create static lib to build a DLL in your project" OFF)

set(LUAJIT_DIR ${CMAKE_CURRENT_LIST_DIR}/LuaJIT)
set(LUAJIT_DYNASM_DIR ${LUAJIT_DIR}/dynasm)
set(LUAJIT_SRC_DIR ${LUAJIT_DIR}/src)
#@rem   amalg         amalgamated build TODO
#@rem   static        create static lib to statically link into your project TODO
#@rem   mixed         create static lib to build a DLL in your project TODO
#  debug         emit debug symbols TODO
#@rem Add more debug flags here, e.g. DEBUGCFLAGS=/DLUA_USE_ASSERT

add_subdirectory(host)