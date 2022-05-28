cd PROJ
git checkout d00501750b210a73f9fb107ac97a683d4e3d8e7a
./autogen.sh
./configure
make -j $(nproc)

$CXX $CXXFLAGS -std=c++11 -I src test/fuzzers/standard_fuzzer.cpp \
    src/.libs/libproj.a $FUZZER_LIB -o ../proj.symsan -lpthread
