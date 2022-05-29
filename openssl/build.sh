CONFIGURE_FLAGS="no-asm"

cd openssl
#git checkout b0593c086dd303af31dc1e30233149978dd613c4

./config --debug enable-fuzz-libfuzzer -DPEDANTIC -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION no-shared enable-tls1_3 enable-rc5 enable-md2 enable-ec_nistp_64_gcc_128 enable-ssl3 enable-ssl3-method enable-nextprotoneg enable-weak-ssl-ciphers --with-fuzzer-lib=${FUZZER_LIB} $CFLAGS -fno-sanitize=alignment $CONFIGURE_FLAGS

make -j$(nproc) LDCMD="$CXX $CXXFLAGS"

fuzzers=$(find fuzz -executable -type f '!' -name \*.py '!' -name \*-test '!' -name \*.pl)
for f in $fuzzers; do
  fuzzer=$(basename $f)
  cp $f ../$fuzzer.symsan
done
