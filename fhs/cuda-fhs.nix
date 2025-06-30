{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSEnv {
  name = "cuda-env";
  targetPkgs = pkgs: with pkgs; [ 
    git
    gitRepo
    gnupg
    autoconf
    curl
    procps
    gnumake
    util-linux
    m4
    gperf
    unzip
    cudatoolkit
    linuxPackages.nvidia_x11
    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 
    ncurses5
    stdenv.cc
    binutils
  ];
  multiPkgs = pkgs: with pkgs; [ zlib ];
  runScript = "zsh";
  profile = ''
    export CUDA_PATH=${pkgs.cudatoolkit}
    
    export PATH=$CUDA_PATH/bin:$GCC_PATH/bin:$PATH
    export LD_LIBRARY_PATH=/run/opengl-driver/lib:${pkgs.linuxPackages.nvidia_x11}/lib:$CUDA_PATH/lib:$LD_LIBRARY

    export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
    export EXTRA_CCFLAGS="-I/usr/include -I$CUDA_PATH/include"
  '';
}).env