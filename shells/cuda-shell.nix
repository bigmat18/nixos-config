{ pkgs ? import <nixpkgs> {} }:
let 
  system = "x86_64-linux";
  nixpkgs-latest = import (pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "bf8717e806f4d5030271c096c2a67bc5834081cd";
      sha256 = "sha256-KQeYFeFMwRKwgv91jcLPpaB1LLfI03Sf5QEYcrDaQ0g=";
    }) { inherit system; config = { allowUnfree = true; }; };
    pkgs_ = nixpkgs-latest;
in 
pkgs.mkShell {
  name = "cuda-env-shell";
  
  buildInputs = with pkgs; [
    git gitRepo gnupg autoconf curl
    procps gnumake util-linux m4 gperf unzip
    
    linuxPackages.nvidia_x11
    cudaPackages.cudatoolkit    
    cudaPackages.cuda_cudart
    cudaPackages.cuda_nvprof

    pkgs_.cudaPackages.nsight_systems
    cudaPackages.nsight_compute

    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 

    ncurses5 stdenv.cc binutils gcc cmake 
    gdb gdbgui clang-tools python313Packages.ninja
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