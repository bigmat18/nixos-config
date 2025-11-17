{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "graphics-env-shell";

  buildInputs = with pkgs; [
      gcc
      cmake
      clang-tools
      pkg-config
      binutils
      ninja
      gdb
      gdbgui
 
      mesa
      libGL
      libGLU
      qt5.full
      glfw

      xorg.libX11.dev
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXxf86vm
      xorg.libXi
      xorg.libxcb
      xorg.libXext

      vulkan-headers
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools

      wayland 
      wayland-protocols
      wayland-scanner
      libxkbcommon
  ];

  shellHook = ''
    echo "✅ Graphics development shell ready" 

    export GCC_PATH=${pkgs.gcc}
    export PATH=$GCC_PATH/bin:$PATH
    export CC=$GCC_PATH/bin/gcc
    export CXX=$GCC_PATH/bin/g++

    exec ${pkgs.zsh}/bin/zsh
  '';
}