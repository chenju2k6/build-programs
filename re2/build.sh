cd re2
git checkout 499ef7eff7455ce9c9fae86111d4a77b6ac335de
make -j $(nproc)

$CXX $CXXFLAGS ../target_re2.cc -I . obj/libre2.a -lpthread $FUZZER_LIB \
    -o ../re2.symsan
