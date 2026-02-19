{ pkgs }:

pkgs.mkShell {
  name = "js-shell";

  buildInputs = with pkgs; [
    bun
    yarn
    sqlite  
    nodejs
  ];

  shellHook = ''
    echo "✅ JS shell ready"
    exec ${pkgs.zsh}/bin/zsh
  '';
}