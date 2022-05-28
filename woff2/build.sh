cd oss-fuzz
git checkout e8ffee4077b59e35824a2e97aa214ee95d39ed13
cd ..

cd brotli
git checkout 3a9032ba8733532a6cd6727970bade7f7c0e2f52
cd ..

cd woff2
git checkout 9476664fd6931ea6ec532c94b816d8fbbe3aed90

for f in font.cc normalize.cc transform.cc woff2_common.cc woff2_dec.cc \
         woff2_enc.cc glyph.cc table_tags.cc variable_length.cc woff2_out.cc; do
  $CXX $CXXFLAGS -std=c++11 -I ../brotli/dec -I ../brotli/enc -c src/$f &
done
for f in ../brotli/dec/*.c ../brotli/enc/*.cc; do
  $CXX $CXXFLAGS -c $f &
done
wait

$CXX $CXXFLAGS *.o $FUZZER_LIB ../target_woff2.cc -I src \
    -o ../woff2.symsan
