#!/usr/bin/env bash

# TODO Consider adding a dependency - libsndfile

#--disable-shared 不能禁用动态链接库ffmpeg需要动态库
AAC_CONFIGURE_FLAGS="--enable-static  --enable-shared --target=android"
echo "TOOLCHAINS_PREFIX:$TOOLCHAINS_PREFIX"

./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT_PATH} \
    $AAC_CONFIGURE_FLAGS \
    CC=${FAM_CC} \
    AR=${FAM_AR} \
    RANLIB=${FAM_RANLIB} || exit 1

export FFMPEG_EXTRA_LD_FLAGS="${FFMPEG_EXTRA_LD_FLAGS} -lm"

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install

echo "Android aac bulid success!"