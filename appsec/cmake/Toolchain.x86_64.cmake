set(sysroot /sysroot/x86_64-none-linux-musl)
set(arch x86_64)
set(interpreter ld-musl-x86_64.so.1)
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR ${arch})
set(CMAKE_SYSROOT ${sysroot})
set(CMAKE_AR /usr/bin/llvm-ar-16)
set(triple ${arch}-none-linux-musl)
set(CMAKE_ASM_COMPILER_TARGET ${triple})
set(CMAKE_C_COMPILER /usr/bin/clang-16)
set(CMAKE_C_COMPILER_TARGET ${triple})

set(c_cxx_flags "-Qunused-arguments -rtlib=compiler-rt -unwindlib=libunwind -static-libgcc -isystem/sysroot/x86_64-none-linux-musl/usr/include/c++/v1/")
set(CMAKE_C_FLAGS ${c_cxx_flags})
set(CMAKE_CXX_COMPILER /usr/bin/clang++-16)
set(CMAKE_CXX_COMPILER_TARGET ${triple})
set(CMAKE_CXX_FLAGS "-stdlib=libc++ ${c_cxx_flags}")

set(linker_flags "-v -fuse-ld=lld-16 -static -nodefaultlibs -lc++ -lc++abi ${sysroot}/usr/lib/libclang_rt.builtins.a -lunwind -lc ${sysroot}/usr/lib/libclang_rt.builtins.a -resource-dir ${sysroot}/usr/lib/resource_dir")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${linker_flags}")
set(CMAKE_SHARED_LINKER_FLAGS_INIT ${linker_flags})

set(CMAKE_NM /usr/bin/llvm-nm-16)
set(CMAKE_RANLIB /usr/bin/llvm-ranlib-16)
set(CMAKE_STRIP /usr/bin/x86_64-linux-gnu-strip) # llvm-strip-11 doesn't seem to work correctly