#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Patch
patch -Np1 -i "${SHED_PKG_PATCH_DIR}/dosbox_svn_r4088_disable_usescancodes.patch" &&
./autogen.sh || exit 1
# Configure
if [ -z "${SHED_PKG_LOCAL_OPTIONS[gl]}" ]; then
    ./configure --prefix=/usr/local \
                --disable-opengl || exit 1
else
    ./configure --prefix=/usr/local || exit 1
fi
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
