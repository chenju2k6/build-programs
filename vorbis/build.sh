readonly INSTALL_DIR="$PWD/INSTALL"

cd ogg
git checkout c8391c2b267a7faf9a09df66b1f7d324e9eb7766
./autogen.sh
./configure \
    --prefix="$INSTALL_DIR" \
    --enable-static \
    --disable-shared \
    --disable-crc
make -j $(nproc)
make install
cd ..

cd vorbis
git checkout c1c2831fc7306d5fbd7bc800324efd12b28d327f
./autogen.sh
./configure \
    --prefix="$INSTALL_DIR" \
    --enable-static \
    --disable-shared
make -j $(nproc)
make install
cd ..

$CXX $CXXFLAGS -std=c++11 ./decode_fuzzer.cc \
    -o vorbis.symsan -L"$INSTALL_DIR/lib" -I"$INSTALL_DIR/include" \
    $FUZZER_LIB -lvorbisfile -lvorbis -logg
