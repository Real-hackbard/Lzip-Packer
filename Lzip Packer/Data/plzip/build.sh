#!/bin/sh

LIBDIR=/plzip/libs$1
INSTDIR=/plzip/inst$1
MYBUILD=i686-w64-mingw32
if [ "$1" = "64" ]; then
  MYHOST=x86_64-w64-mingw32
else
  MYHOST=i686-w64-mingw32
fi

mkdir b-pthread$1
cd b-pthread$1
../winpthreads/configure --prefix=$LIBDIR --disable-shared --enable-static --build=$MYBUILD --host=$MYHOST || exit 1
make || exit 1
make install || exit 1
cd ..

mkdir b-lzlib$1
cd b-lzlib$1
../lzlib-1.5/configure --prefix=$LIBDIR CFLAGS="-O3" || exit 1
make || exit 1
make install || exit 1
cd ..

mkdir b-plzip$1
cd b-plzip$1
../plzip-1.1/configure --prefix=$INSTDIR CPPFLAGS="-I$LIBDIR/include" CXXFLAGS="-O3" LDFLAGS="-L$LIBDIR/lib" || exit 1
make || exit 1
make install-strip || exit 1
cd ..
