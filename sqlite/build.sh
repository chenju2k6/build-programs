cd sqlite
mkdir bld
cd bld

export ASAN_OPTIONS=detect_leaks=0

# Limit max length of data blobs and sql queries to prevent irrelevant OOMs.
# Also limit max memory page count to avoid creating large databases.
export CFLAGS="$CFLAGS -DSQLITE_MAX_LENGTH=128000000 \
               -DSQLITE_MAX_SQL_LENGTH=128000000 \
               -DSQLITE_MAX_MEMORY=25000000 \
               -DSQLITE_PRINTF_PRECISION_LIMIT=1048576 \
               -DSQLITE_DEBUG=1 \
               -DSQLITE_MAX_PAGE_COUNT=16384"

../configure
make -j$(nproc)
make sqlite3.c

$CC $CFLAGS -I. -c \
    ../test/ossfuzz.c -o ../test/ossfuzz.o

$CXX $CXXFLAGS \
    ../test/ossfuzz.o -pthread -ldl -o ../sqlite.symsan \
    $LIB_FUZZING_ENGINE ./sqlite3.o
