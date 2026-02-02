cmake_minimum_required(VERSION 3.16)

project(hmi-ivi LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

add_executable(hmi-ivi
    main.cpp
    qml.qrc
)

target_link_libraries(hmi-ivi
    PRIVATE Qt6::Quick
)

install(TARGETS hmi-ivi
    RUNTIME DESTINATION bin
)
