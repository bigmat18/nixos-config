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

      pkgs.qt5.full
      pkgs.qtcreator
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.vulkan-loader}/lib:$LD_LIBRARY_PATH
    export PATH=${pkgs.gdb}/bin:$PATH
    exec ${pkgs.zsh}/bin/zsh
  '';
}