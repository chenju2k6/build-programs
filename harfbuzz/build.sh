cd harfbuzz
git checkout f73a87d9a8c76a181794b74b527ea268048f78e3
./autogen.sh
(cd ./src/hb-ucdn && CCLD="$CXX $CXXFLAGS" make)
CCLD="$CXX $CXXFLAGS" ./configure --enable-static --disable-shared \
    --with-glib=no --with-cairo=no
make -j $(nproc) -C src fuzzing


$CXX $CXXFLAGS -std=c++11 -I src/ test/fuzzing/hb-fuzzer.cc \
    src/.libs/libharfbuzz-fuzzing.a $FUZZER_LIB -o ../harfbuzz.symsan
