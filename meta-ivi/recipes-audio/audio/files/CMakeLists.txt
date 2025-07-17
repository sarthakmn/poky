cmake_minimum_required(VERSION 3.10)
project(pfaudio)

# Correct include path
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/inc)

# ALSA
find_package(PkgConfig REQUIRED)
pkg_check_modules(ALSA REQUIRED alsa)
include_directories(${ALSA_INCLUDE_DIRS})
link_directories(${ALSA_LIBRARY_DIRS})

# Source files
add_executable(pfaudio
    main.cpp
    src/audio.cpp
)

target_link_libraries(pfaudio ${ALSA_LIBRARIES})

