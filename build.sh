#!/bin/bash
# Disable keyboard scancodes by default to prevent input issues
patch -Np1 -i "${SHED_PATCHDIR}/dosbox_svn_r4088_disable_usescancodes.patch" &&
./autogen.sh &&
./configure --prefix=/usr/local \
            --disable-opengl &&
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
