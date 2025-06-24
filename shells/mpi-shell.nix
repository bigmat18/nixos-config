# shell.nix
{ pkgs }:

pkgs.mkShell {
  name = "mpi-env-shell";

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