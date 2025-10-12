{ pkgs }:

pkgs.mkShell {
  name = "js-shell";

  buildInputs = with pkgs; [
    bun
  ];

  shellHook = ''
    echo "✅ JS shell ready"
    exec ${pkgs.zsh}/bin/zsh
  '';
}