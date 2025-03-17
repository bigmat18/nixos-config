{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
      cmake
      gcc
      pkg-config
      ninja
      gdb

      mesa.dev
      libGL
      xorg.libX11.dev
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXxf86vm
      xorg.libXi
  ];

  shellHook = ''
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh
    echo "✅ Ambiente di sviluppo C++ pronto!"
  '';
}