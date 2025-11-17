set(
    Source_Files
    "${LUAJIT_SRC_DIR}/host/minilua.c"
)

source_group(
    TREE "${LUAJIT_SRC_DIR}/host" 
    PREFIX "Source Files" 
    FILES ${Source_Files}
)

add_executable(minilua)

target_sources(
    minilua
    PRIVATE 
    ${Source_Files}
)

add_custom_target()