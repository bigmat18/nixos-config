{ pkgs }:

pkgs.mkShell {
  name = "mpi-env-shell";

  buildInputs = with pkgs; [
    pyright
    python313Packages.pip
    python313Packages.numpy
    python313Packages.matplotlib
    python313Packages.pymeshlab
  ];

  shellHook = ''
    echo "✅ PY shell ready"
    exec ${pkgs.zsh}/bin/zsh
  '';
}