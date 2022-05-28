cd jsoncpp

mkdir -p build
cd build
cmake -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
      -DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF -DJSONCPP_WITH_TESTS=OFF \
      -DBUILD_SHARED_LIBS=OFF -G "Unix Makefiles" ..
make

# Compile fuzzer.
$CXX $CXXFLAGS -I../include $FUZZER_LIB \
    ../src/test_lib_json/fuzz.cpp -o ../jsoncpp.symsan \
    ./lib/libjsoncpp.a
