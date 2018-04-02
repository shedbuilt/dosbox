#!/bin/bash
# shedmake doesn't natively support zip archives so we have to manually unpack the snapshot
unzip dosbox-code-0-4088-dosbox-trunk.zip &&
cd dosbox-code-0-4088-dosbox-trunk &&
patch -Np1 -i "${SHED_PATCHDIR}/dosbox_svn_r4088_disable_usescancodes.patch" &&
./autogen.sh &&
./configure --prefix=/usr/local \
            --disable-opengl || exit 1
if [ "$SHED_CPU_CORE" == 'cortex-a7' ]; then
    # Enable the dynamic recompilation core on armv7l devices
    sed -i 's|/\* #undef C_DYNREC \*/|#define C_DYNREC 1|' config.h
    sed -i 's/C_TARGETCPU.*/C_TARGETCPU ARMV7LE/g' config.h
    sed -i 's|/\* #undef C_UNALIGNED_MEMORY \*/|#define C_UNALIGNED_MEMORY 1|' config.h
fi
make -j $SHED_NUMJOBS &&
make DESTDIR="$SHED_FAKEROOT" install
