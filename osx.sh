#!/usr/bin/env bash

export CC=clang

DISK_ID=$(hdid -nomount ram://2621440)
newfs_hfs -v Ramdisk ${DISK_ID}
diskutil mount ${DISK_ID}

MES=/Packages/
TARGET="/Volumes/Ramdisk/sw"
CMPL="/Volumes/Ramdisk/compile"

mkdir ${TARGET}
mkdir ${CMPL}
export PATH=${TARGET}/bin:$PATH

cd ${CMPL}
git clone --depth 1 git://github.com/yasm/yasm.git
cd yasm
autoreconf -fiv
./configure --prefix=${TARGET}
make -J 4
make install
make distclean

cd ${CMPL}
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix=${TARGET} --bindir="$HOME/bin" --disable-shared --enable-nasm --enable-static
make -j 4
make install
make distclean


cd ${CMPL}
git clone --depth 1 http://git.code.sf.net/p/opencore-amr/fdk-aac
cd fdk-aac
autoreconf -fiv
./configure --prefix=${TARGET} --disable-shared
make -j 4
make install
make distclean

cd ${CMPL}
git clone --depth 1 git://git.videolan.org/x264
cd x264
./configure --prefix=${TARGET} --disable-shared --enable-static
make -j 4
make install
make install-lib-static
make distclean


unset LDFLAGS CFLAGS MYFLAGS
export MYFLAGS="-L${TARGET}/lib -I${TARGET}/include -lstdc++"
export LDFLAGS="$MYFLAGS"
export CFLAGS="$MYFLAGS"

cd ${CMPL}
git clone git://git.videolan.org/ffmpeg.git ffmpeg
cd ffmpeg
git co -b Rel2.8 remotes/origin/release/2.8
./configure --prefix=${TARGET} --extra-version=NTDTV_11052015 --disable-shared --enable-static --enable-gpl --enable-pthreads --enable-nonfree  --enable-libfdk-aac  --enable-libmp3lame  --enable-libx264 --enable-filters --arch=x86_64 --enable-runtime-cpudetect
make -j 4
make install
#make distclean
#hash -r
