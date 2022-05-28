cd libpng-1.2.56
./configure
make -j $(nproc)

$CXX $CXXFLAGS -std=c++11 ../target_libpng.cc .libs/libpng12.a $FUZZER_LIB -I . -lz \
    -o ../libpng.symsan
