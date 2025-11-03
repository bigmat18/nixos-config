{ pkgs }:

pkgs.mkShell {
  name = "js-shell";

  buildInputs = with pkgs; [
    bun
    yarn

    pyright
    python313Packages.matplotlib
    python313Packages.pandas
  ];

  shellHook = ''
    echo "✅ JS shell ready"
    exec ${pkgs.zsh}/bin/zsh
  '';
}