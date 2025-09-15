{ pkgs }:

pkgs.mkShell {
  name = "mpi-env-shell";

  buildInputs = with pkgs; [
    cmake
    gcc
    clang-tools
    pkg-config
    ninja
    binutils 
    gdb
    gdbgui
    openmpi
    pyright
    llvmPackages.openmp
  ];

  shellHook = ''
    export GCC_PATH=${pkgs.gcc}

    export PATH=$GCC_PATH/bin:$PATH
    export CC=$GCC_PATH/bin/gcc
    export CXX=$GCC_PATH/bin/g++

    exec ${pkgs.zsh}/bin/zsh
  '';
}