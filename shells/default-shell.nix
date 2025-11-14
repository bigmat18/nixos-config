{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "default-env-shell";

  buildInputs = with pkgs; [
      gcc
      cmake
      clang
      clang-tools
      pkg-config
      ninja
      gdb
      gdbgui
 
      mesa
      libGL
      libGLU
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

      nimble
      nim-unwrapped
      qt5.full
      glfw

  ];

  shellHook = ''
    echo "✅ Default development shell ready"
    export LD_LIBRARY_PATH=${pkgs.mesa}/lib:${pkgs.libGL}/lib:${pkgs.glfw}/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=${pkgs.vulkan-loader}/lib:$LD_LIBRARY_PATH    

    export GCC_PATH=${pkgs.gcc}

    export PATH=$GCC_PATH/bin:$PATH
    export CC=$GCC_PATH/bin/gcc
    export CXX=$GCC_PATH/bin/g++

    exec ${pkgs.zsh}/bin/zsh
  '';
}