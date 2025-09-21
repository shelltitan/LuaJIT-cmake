set(
    Source_Files
    "${LUAJIT_SRC_DIR}/host/minilua.c"
)

source_group(
    TREE "${LUAJIT_SRC_DIR}/host" 
    PREFIX "Source Files" 
    FILES ${Source_Files}
)

set(
    ALL_FILES
    ${Source_Files}
)

set(
    MODULE_NAME
    minilua
)

add_executable(
    ${MODULE_NAME}
    ${ALL_FILES}
)