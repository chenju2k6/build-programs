cd Little-CMS
git checkout f9d75ccef0b54c9f4167d95088d4727985133c52
./autogen.sh
./configure
make -j $(nproc)

$CXX $CXXFLAGS ../target_lcms.cc -I include/ src/.libs/liblcms2.a \
    $FUZZER_LIB -o ../lcms.symsan
