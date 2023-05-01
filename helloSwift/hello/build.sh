# bash build.sh
# bash build.sh clean

# install directory layout

# |-- app
# |   `-- hello
# `-- lib
#     |-- libbar.dylib
#     |-- libbar.dylib.1
#     `-- libbar.dylib.1.2.3

if [[ $1 == "clean" ]]; then
    make -C "`pwd`/Sources" clean
    swift package clean
else
    # release: NDEBUG=1
    make -C "`pwd`/Sources" # NDEBUG=1
    # debug/release
    swift build -c debug \
        -Xlinker -LSources/build/bar \
        -Xlinker -lbar \
        -Xlinker -rpath -Xlinker "`pwd`/Sources/build/bar" \
        -Xlinker -rpath -Xlinker @executable_path/../lib
fi
