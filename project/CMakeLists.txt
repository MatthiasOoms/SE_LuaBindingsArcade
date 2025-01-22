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

set_source_files_properties("source/Game.cpp" PROPERTIES COMPILE_FLAGS "/bigobj")

# Create the executable with the Windows subsystem
add_executable(${PROJECT_NAME} ${SOURCES})

# Link the project with the lua and sol2 libraries
target_link_libraries(${PROJECT_NAME} PRIVATE lua::lua sol2)

# Set entry point to wWinMain
set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS "/ENTRY:wWinMainCRTStartup")

# Copy resources to output folder
set(RESOURCES_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/resources/")
file(GLOB_RECURSE ALL_FILES
    "${RESOURCES_SOURCE_DIR}/*"
)

# Filter out .lua files
foreach(RESOURCE ${ALL_FILES})
    if(NOT RESOURCE MATCHES "annotations.lua")
        if(NOT RESOURCE MATCHES "\\.lua$")
            # add all other files to the resource files
            list(APPEND RESOURCE_FILES ${RESOURCE})
        else()
            # add .lua files to the lua sources
            list(APPEND LUA_SOURCES ${RESOURCE})
        endif()
    else()
        # add annotations.lua to the resource files
        list(APPEND RESOURCE_FILES ${RESOURCE})
    endif()
endforeach()

set(RESOURCES_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/resources/")
file(MAKE_DIRECTORY ${RESOURCES_OUT_DIR})
foreach(RESOURCE ${RESOURCE_FILES})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${RESOURCE}" "${RESOURCES_OUT_DIR}"
    )
endforeach()

foreach(RESOURCE ${LUA_SOURCES})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy "${RESOURCE}" "${CMAKE_CURRENT_BINARY_DIR}"
    )
endforeach()