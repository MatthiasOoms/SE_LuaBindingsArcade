cmake_minimum_required(VERSION 3.27)

# Project Name
project(SE_Arcade)

# Use C++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add project subdirectory
add_subdirectory(project)

# Add UNICODE to the project as a compile definition
target_compile_definitions(${PROJECT_NAME} PRIVATE _UNICODE UNICODE)