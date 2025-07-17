#include "audio.h"
#include <cstdio>

int main() {
    const char *songs[] = {
        "/etc/res/california.wav",
    };

    for (int i = 0; i < 3; ++i) {
        printf("Playing: %s\n", songs[i]);
        play_wav(songs[i]);
    }

    return 0;
}
