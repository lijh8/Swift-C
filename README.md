# swift-c

Call C function in .so shared library from Swift

rename output file from hello to libhello.so after build it

no pkg-config, dnf, yum, apt

swift build -Xlinker -L../hello

cp libhello.so .build/debug

