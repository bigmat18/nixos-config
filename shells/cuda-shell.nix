{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "cuda-env-shell";
  
  buildInputs = with pkgs; [
    git gitRepo gnupg autoconf curl bear
    procps gnumake util-linux m4 gperf unzip
    
    linuxPackages.nvidia_x11
    cudaPackages.cudatoolkit
    cudaPackages.cuda_cudart
    cudaPackages.cuda_nvprof

    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 

    ncurses5 stdenv.cc binutils gcc cmake 
    gdb gdbgui clang-tools python313Packages.ninja 
    
    pyright
    python313Packages.matplotlib
    python313Packages.pandas
    llvmPackages.openmp
  ];

   shellHook = ''
      export CUDA_PATH=${pkgs.cudaPackages.cudatoolkit}/
      export GCC_PATH=${pkgs.gcc}

      export PATH=$CUDA_PATH/bin:$GCC_PATH/bin:$PATH
      export LD_LIBRARY_PATH=/run/opengl-driver/lib:${pkgs.linuxPackages.nvidia_x11}/lib:$CUDA_PATH/lib:$LD_LIBRARY_PATH

      export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
      export EXTRA_CCFLAGS="-I/usr/include -I$CUDA_PATH/include"

      export CC=$GCC_PATH/bin/gcc
      export CXX=$GCC_PATH/bin/g++

      exec ${pkgs.zsh}/bin/zsh
   '';
}