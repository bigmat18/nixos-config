{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "cuda-env-shell";
  
  buildInputs = with pkgs; [
    git gitRepo gnupg autoconf curl
    procps gnumake util-linux m4 gperf
    
    cudatoolkit linuxPackages.nvidia_x11
    cudaPackages.cudatoolkit
    cudaPackages.cuda_cudart
    cudaPackages.cuda_nvprof
    cudaPackages.nsight_compute
    cudaPackages.nsight_systems

    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib

    ncurses5 stdenv.cc binutils gcc cmake gdb gdbgui clang-tools python313Packages.ninja
  ];
   shellHook = ''
      export LD_LIBRARY_PATH=/run/opengl-driver/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudatoolkit}/lib:$LD_LIBRARY_PATH
      export CUDA_PATH=${pkgs.cudatoolkit}/
      export PATH=$CUDA_PATH/bin:$PATH
      export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
      export EXTRA_CCFLAGS="-I/usr/include -I$CUDA_PATH/include"
      exec ${pkgs.zsh}/bin/zsh
   '';

}