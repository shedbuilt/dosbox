#!/bin/bash
# shedmake doesn't natively support zip archives so we have to manually unpack the snapshot
unzip dosbox-code-0-4088-dosbox-trunk.zip &&
cd dosbox-code-0-4088-dosbox-trunk &&
patch -Np1 -i "${SHED_PATCHDIR}/dosbox_svn_r4088_disable_usescancodes.patch" &&
./autogen.sh &&
./configure --prefix=/usr/local \
            --disable-opengl &&
make -j $SHED_NUMJOBS &&
make DESTDIR="$SHED_FAKEROOT" install
