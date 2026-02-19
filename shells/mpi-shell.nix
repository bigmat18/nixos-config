{ pkgs }:

pkgs.mkShell {
  name = "mpi-env-shell";

  NIX_ENFORCE_NO_NATIVE = "0";

  buildInputs = with pkgs; [
    cmake
    gcc
    clang-tools
    pkg-config
    ninja
    binutils 
    gdb
    gdbgui
    openmpi
    llvmPackages.openmp
  ];

  shellHook = ''
    echo "✅ MPI shell ready"
    exec ${pkgs.zsh}/bin/zsh
  '';
}