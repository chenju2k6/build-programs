#!/bin/bash

export CC=/symsan/bin/ko-clang
export CXX=/symsan/bin/ko-clang++
export KO_CC=clang-6.0
export KO_CXX=clang++-6.0
export FUZZER_LIB=$PWD/driver_symsan.a
export LIB_FUZZING_ENGINE=$PWD/driver_symsan.a
export CFLAGS=
export CXXFLAGS=
export KO_DONT_OPTIMIZE=1
export OUT=$PWD
export ARCHITECTURE=
export SANITIZER=

$CC -c standaloneengine.c -o driver_symsan.o
ar r driver_symsan.a driver_symsan.o

cp driver_symsan.a /usr/lib/libFuzzingEngine.a

mkdir -p binutils
echo "binutils"

cd binutils
wget https://ftp.gnu.org/gnu/binutils/binutils-2.33.1.tar.gz
tar xvf binutils-2.33.1.tar.gz
cd binutils-2.33.1
./configure --disable-shared
make -j
cp binutils/nm-new ../../nm.symsanfast
cp binutils/size ../../size.symsanfast
cp binutils/objdump ../../objdump.symsanfast
cp binutils/readelf ../../readelf.symsanfast
cd ../..


echo "libjpeg"

cd libjpeg
git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git
./build.sh
cp libjpeg.symsan ../libjpeg.symsanfast
cd ..

echo "libpng"
cd libpng
tar xvf libpng-1.2.56.tar.gz
./build.sh
cp libpng.symsan ../libpng.symsanfast
cd ..

echo "freetype"
cd freetype
tar xvf freetype2.tar.gz 
tar xvf libarchive-3.4.3.tar.xz
./build.sh
cp freetype.symsan ../freetype.symsanfast
cd ..

echo "harfbuzz"
cd harfbuzz
git clone https://github.com/behdad/harfbuzz.git
./build.sh
cp harfbuzz.symsan ../harfbuzz.symsanfast
cd ..

echo "jsoncpp"
cd json
git clone https://github.com/open-source-parsers/jsoncpp
./build.sh
cp jsoncpp/jsoncpp.symsan ../json.symsanfast
cd ..


echo "lcms"
cd lcms
git clone https://github.com/mm2/Little-CMS.git
./build.sh
cp lcms.symsan ../lcms.symsanfast
cd ..

echo "xml"
cd xml
git clone https://gitlab.gnome.org/GNOME/libxml2.git
./build.sh
cp xml.symsan ../xml.symsanfast
cd ..

echo "openssl"
cd openssl
git clone https://github.com/openssl/openssl.git
./build.sh
cp x509.symsan ../openssl.symsanfast
cd ..

echo "vorbis"
cd vorbis
git clone  https://github.com/xiph/ogg.git
git clone https://github.com/xiph/vorbis.git
./build.sh
cp vorbis.symsan ../vorbis.symsanfast
cd ..

echo "woff2"
cd woff2
git clone https://github.com/google/woff2.git
git clone https://github.com/google/oss-fuzz.git
git clone https://github.com/google/brotli.git
./build.sh
cp woff2.symsan ../woff2.symsanfast
cd ..

echo "re2"
cd re2
git clone https://github.com/google/re2.git
./build.sh
cp re2.symsan ../re2.symsanfast
cd ..


echo "proj"
cd proj
git clone https://github.com/OSGeo/PROJ
./build.sh
cp proj.symsan ../proj.symsanfast
cd ..


echo "openthread"
cd openthread
git clone https://github.com/openthread/openthread.git
./build.sh
cp openthread.symsan ../openthread.symsanfast
cd ..


echo  "sqlite"
cd sqlite
tar xvf sqlite3.tar.gz
./build.sh
cp sqlite/sqlite.symsan ../sqlite.symsanfast
cd ..

echo "mbedtls"
cd mbedtls
git clone https://github.com/openssl/openssl.git
git clone https://github.com/google/boringssl.git
git clone https://github.com/ARMmbed/mbedtls.git
git clone https://github.com/ARMmbed/mbed-crypto mbedtls/crypto
./build.sh
cp mbedtls/programs/fuzz/fuzz_dtlsclient ../mbedtls.symsanfast
cd ..

echo "curl"
cd curl
git clone https://github.com/curl/curl.git
git clone https://github.com/curl/curl-fuzzer.git curl_fuzzer
cp ossfuzz.sh curl_fuzzer
cp install_openssl.sh curl_fuzzer/scripts/
./build.sh
cp curl_fuzzer/curl_fuzzer_http ../curl.symsanfast

