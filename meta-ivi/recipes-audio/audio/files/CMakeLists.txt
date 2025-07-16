cmake_minimum_required(VERSION 3.10)
project(pfaudio)

include_directories(${INCLUDE_DIR})

add_executable(pfaudio
    main.cpp
    src/audio.cpp
)

