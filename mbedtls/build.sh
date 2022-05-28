cd mbedtls
perl scripts/config.pl set MBEDTLS_PLATFORM_TIME_ALT
git -C crypto checkout -f 819799cfc68e4c4381673a8a27af19802c8263f2
make -j
mkdir build
cd build
cmake ..
# build including fuzzers
make -j$(nproc) all
