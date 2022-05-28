
cd libarchive-3.4.3
./configure --disable-shared --without-xml2
make clean
make -j $(nproc)
cd ..

cd freetype2
git checkout cd02d359a6d0455e9d16b87bf9665961c4699538
./autogen.sh
./configure --with-harfbuzz=no --with-bzip2=no --with-png=no --without-zlib
make clean
make all -j $(nproc)

$CXX $CXXFLAGS -std=c++11 -I include -I . -I ../libarchive-3.4.3/libarchive src/tools/ftfuzzer/ftfuzzer.cc \
    objs/.libs/libfreetype.a $FUZZER_LIB ../libarchive-3.4.3/.libs/libarchive.a \
    -o ../freetype.symsan
