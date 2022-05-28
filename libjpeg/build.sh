cd libjpeg-turbo
git checkout b0971e47d76fdb81270e93bbf11ff5558073350d
autoreconf -fiv
./configure --disable-shared --without-simd
make -j $(nproc)

$CXX $CXXFLAGS -std=c++11 ../libjpeg_turbo_fuzzer.cc -I . \
    .libs/libturbojpeg.a $FUZZER_LIB -o ../libjpeg.symsan
