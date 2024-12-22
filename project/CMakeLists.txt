# Source files
set(SOURCES 
    "source/AbstractGame.cpp"
    "source/Game.cpp"
    "source/GameEngine.cpp"
    "source/GameWinMain.cpp"
    "source/GameDefines.h"
    "source/resource.h"
)

# Create the executable with the Windows subsystem
add_executable(${PROJECT_NAME} ${SOURCES})

# Set entry point to wWinMain
set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "/ENTRY:wWinMainCRTStartup")

# Copy resources to output folder
set(RESOURCES_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/resources/")
file(GLOB_RECURSE RESOURCE_FILES
    "${RESOURCES_SOURCE_DIR}/*"
)

set(RESOURCES_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/resources/")
file(MAKE_DIRECTORY ${RESOURCES_OUT_DIR})
foreach(RESOURCE ${RESOURCE_FILES})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${RESOURCE}" "${RESOURCES_OUT_DIR}"
    )
endforeach()