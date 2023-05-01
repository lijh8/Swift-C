# bash build.sh
# bash build.sh clean

if [[ $1 == "clean" ]]; then
    gmake -C `pwd`/Sources clean
    swift package clean
else
    # release: NDEBUG=1
    gmake -C `pwd`/Sources # NDEBUG=1
    # debug/release
    swift build -c debug \
        -Xswiftc -LSources/build/bar \
        -Xlinker -lbar \
        -Xlinker -rpath -Xlinker Sources/build/bar
fi
