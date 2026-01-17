{ pkgs }:

pkgs.mkShell {
  name = "js-shell";

  buildInputs = with pkgs; [
    bun
    yarn
    sqlite

    pyright
    python313Packages.pip
    python313Packages.numpy
    python313Packages.matplotlib
    virtualenv
  ];

  shellHook = ''
    echo "✅ JS shell ready"
    exec ${pkgs.zsh}/bin/zsh
  '';
}