#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

#define BUFFER_SIZE 4096
void play_wav(const char *filename);

