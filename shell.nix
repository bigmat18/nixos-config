{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
      cmake
      gcc
      pkg-config
      ninja
      gdb
      gdbgui

      mesa
      libGL
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
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.vulkan-loader}/lib:$LD_LIBRARY_PATH
    export SHELL=${pkgs.zsh}/bin/zsh
    export PATH=${pkgs.gdb}/bin:$PATH
    exec ${pkgs.zsh}/bin/zsh
    echo "✅ Ambiente di sviluppo C++ pronto!"
  '';
}