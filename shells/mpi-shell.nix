# shell.nix
{ pkgs }:

pkgs.mkShell {

  buildInputs = with pkgs; [
    cmake
    gcc
    clang
    clang-tools
    pkg-config
    ninja

    gdb
    gdbgui

    cmake
    pkg-config
    openmpi
    llvmPackages.openmp
  ];

  shellHook = ''
    exec ${pkgs.zsh}/bin/zsh
  '';
}