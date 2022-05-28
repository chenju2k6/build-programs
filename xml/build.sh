cd libxml2
# Git is converting CRLF to LF automatically and causing issues when checking
# out the branch. So use -f to ignore the complaint about lost changes that we
# don't even want.
git checkout -f v2.9.2
./autogen.sh
./configure --without-python --with-threads=no --with-zlib=no --with-lzma=no
make -j $(nproc)

$CXX $CXXFLAGS -std=c++11 ../target_libxml2.cc $FUZZER_LIB -I include .libs/libxml2.a -lm  -o ../xml.symsan
