#include "audio.h"

void play_wav(const char *filename) {
    FILE *file = fopen(filename, "rb");
    if (!file) {
        perror("File open failed");
        return;
    }

    // Skip WAV header (first 44 bytes)
    fseek(file, 44, SEEK_SET);

    snd_pcm_t *handle;
    snd_pcm_hw_params_t *params;
    int rc;
    unsigned int rate = 44100;
    int channels = 2;
    snd_pcm_uframes_t frames = 32;
    char *buffer = (char *)malloc(BUFFER_SIZE);

    rc = snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
    if (rc < 0) {
        fprintf(stderr, "Unable to open PCM device: %s\n", snd_strerror(rc));
        return;
    }

    snd_pcm_hw_params_malloc(&params);
    snd_pcm_hw_params_any(handle, params);
    snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_channels(handle, params, channels);
    snd_pcm_hw_params_set_rate_near(handle, params, &rate, 0);
    snd_pcm_hw_params_set_period_size_near(handle, params, &frames, 0);
    snd_pcm_hw_params(handle, params);

    while (!feof(file)) {
        size_t read_size = fread(buffer, 1, BUFFER_SIZE, file);
        if (read_size > 0) {
            rc = snd_pcm_writei(handle, buffer, read_size / 4); // 2 bytes * 2 channels
            if (rc == -EPIPE) {
                snd_pcm_prepare(handle);
            } else if (rc < 0) {
                fprintf(stderr, "Error writing to PCM device: %s\n", snd_strerror(rc));
            }
        }
    }

    snd_pcm_drain(handle);
    snd_pcm_close(handle);
    free(buffer);
    fclose(file);
}

