#!/usr/bin/env bash

# TODO Consider adding a dependency - libsndfile

#--disable-shared 不能禁用动态链接库ffmpeg需要动态库
AAC_CONFIGURE_FLAGS="--enable-static  --enable-shared --enable-pic --enable-strip --target=android"
echo "TOOLCHAINS_PREFIX:${TOOLCHAINS_PREFIX}"
echo "${pwd}"
echo "INSTALL_DIR:${INSTALL_DIR}" 

echo "TARGET:${TARGET}" 
./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT_PATH} \
    $AAC_CONFIGURE_FLAGS \
    CC=${FAM_CC} \
    AR=${FAM_AR} \
    RANLIB=${FAM_RANLIB} || exit 1

export FFMPEG_EXTRA_LD_FLAGS="${FFMPEG_EXTRA_LD_FLAGS} -L${INSTALL_DIR}/lib"

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
echo "Android aac make success!"
${MAKE_EXECUTABLE} install

echo "Android aac install success!"
