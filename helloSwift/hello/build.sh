# bash build.sh
# bash build.sh clean

if [[ $1 == "clean" ]]; then
    gmake -C `pwd`/Sources clean
    swift package clean
else
    gmake -C `pwd`/Sources
    swift build -c debug -Xswiftc -LSources/build/bar -Xlinker -rpath -Xlinker Sources/build/bar -Xlinker -lbar
fi
