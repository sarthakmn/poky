#!/bin/sh

# Runtime directory (required by Qt)
mkdir -p /run/user/0
chmod 0700 /run/user/0
export XDG_RUNTIME_DIR=/run/user/0

# EGLFS configuration for Raspberry Pi
export QT_QPA_PLATFORM=eglfs
export QT_QPA_EGLFS_INTEGRATION=eglfs_kms
export QT_QPA_EGLFS_KMS_ATOMIC=0
export QT_QPA_EGLFS_ALWAYS_SET_MODE=1

# Optional debugging
# export QT_LOGGING_RULES="qt.qpa.*=true"

exec /usr/bin/hmi-ivi "$@"
