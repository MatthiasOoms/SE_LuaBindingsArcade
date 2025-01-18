# FetchContent
include(FetchContent)

# Fetch LUA
FetchContent_Declare(
    lua
    URL https://github.com/marovira/lua/archive/refs/tags/5.4.4.tar.gz
)
FetchContent_MakeAvailable(lua)

# Fetch SOL2
FetchContent_Declare(
    sol2
    URL https://github.com/ThePhD/sol2/archive/refs/tags/v3.3.0.tar.gz
)
FetchContent_MakeAvailable(sol2)

# Source files
set(SOURCES 
    "source/Game.cpp"
    "source/GameEngine.cpp"
    "source/GameWinMain.cpp"
    "source/AbstractGame.cpp"
)

set(LUA_SOURCES
    "resources/brickbreak.lua"
)

# Create the executable with the Windows subsystem
add_executable(${PROJECT_NAME} ${SOURCES} ${LUA_SOURCES})

# Link the project with the lua and sol2 libraries
target_link_libraries(${PROJECT_NAME} PRIVATE lua::lua sol2)

# Add the source directory to the include directories
#target_include_directories(${PROJECT_NAME} PRIVATE source)

# Set entry point to wWinMain
set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "/ENTRY:wWinMainCRTStartup")

# Copy resources to output folder
set(RESOURCES_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/resources/")
file(GLOB_RECURSE ALL_FILES
    "${RESOURCES_SOURCE_DIR}/*"
)

# Filter out .lua files
foreach(RESOURCE ${ALL_FILES})
    if(NOT RESOURCE MATCHES "\\.lua$")
        list(APPEND RESOURCE_FILES ${RESOURCE})
    else()
        list(APPEND LUA_FILES ${RESOURCE})
    endif()
endforeach()

set(RESOURCES_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/resources/")
file(MAKE_DIRECTORY ${RESOURCES_OUT_DIR})
foreach(RESOURCE ${RESOURCE_FILES})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${RESOURCE}" "${RESOURCES_OUT_DIR}"
    )
endforeach()

foreach(RESOURCE ${LUA_FILES})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${RESOURCE}" "${CMAKE_CURRENT_BINARY_DIR}"
    )
endforeach()