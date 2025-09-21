set(DASM_LUA   "${LUAJIT_DYNASM_DIR}/dynasm.lua")
set(DASC_X64   "${LUAJIT_SRC_DIR}/vm_x64.dasc")
set(DASC_X86   "${LUAJIT_SRC_DIR}/vm_x86.dasc")
set(DASC_ARM64 "${LUAJIT_SRC_DIR}/vm_arm64.dasc")
set(DASMFLAGS_BASE -D WIN -D JIT -D FFI -D ENDIAN_LE -D FPU) # this is for windows

set(SELECTED_DASC "${DASC_X64}")
set(SELECTED_DASMFLAGS ${DASMFLAGS_BASE})
set(DASMTARGET "")            # extra target macro for arm64
set(LJARCH "x64") 

if ((CMAKE_SIZEOF_VOID_P EQUAL 4) OR LUAJIT_DISABLE_GC)
    set(SELECTED_DASC "${DASC_X86}")
endif()
if(CMAKE_SIZEOF_VOID_P EQUAL 4)
    set(LJARCH "x86")
endif()

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/buildvm_arch.h
  COMMAND ${DASM_LUA} -LN ${SELECTED_DASMFLAGS}
  DEPENDS minilua
)

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/luajit_relver.txt
  COMMAND git show -s --format=%ct > ${CMAKE_CURRENT_BINARY_DIR}/luajit_relver.txt
  WORKING_DIRECTORY ${LUAJIT_DIR}
)

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/luajit.h
  COMMAND $<TARGET_FILE:minilua> ${LUAJIT_SRC_DIR}/host/genversion.lua
  ARGS ${LUAJIT_SRC_DIR}/luajit_rolling.h
       ${CMAKE_CURRENT_BINARY_DIR}/luajit_relver.txt
       ${CMAKE_CURRENT_BINARY_DIR}/luajit.h
  DEPENDS ${LUAJIT_SRC_DIR}/luajit_rolling.h
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/luajit_relver.txt
)

set(
    Header_Files
    "${CMAKE_CURRENT_BINARY_DIR}/buildvm_arch.h"
    "${LUAJIT_SRC_DIR}/buildvm.h"
    "${LUAJIT_SRC_DIR}/buildvm_libbc.h"
)

source_group(
	TREE "${LUAJIT_SRC_DIR}/host"
	PREFIX "Header Files"
	FILES ${Header_Files}
)

set(
    Source_Files
    "${LUAJIT_SRC_DIR}/host/buildvm.c"
    "${LUAJIT_SRC_DIR}/host/buildvm_asm.c"
    "${LUAJIT_SRC_DIR}/host/buildvm_fold.c"
    "${LUAJIT_SRC_DIR}/host/buildvm_lib.c"
    "${LUAJIT_SRC_DIR}/host/buildvm_peobj.c"
)

source_group(
    TREE "${LUAJIT_SRC_DIR}/host"
    PREFIX "Source Files"
    FILES ${Source_Files}
)

set(
    MODULE_NAME
    buildvm
)

add_executable(
    ${MODULE_NAME}
    ${ALL_FILES}
)

if (MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 4)
    target_compile_options(${MODULE_NAME} PRIVATE /arch:SSE2)
endif()