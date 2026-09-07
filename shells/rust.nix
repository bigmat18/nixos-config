{ pkgs, vars, ... }:

pkgs.mkShell {
  name = "rust-env-shell";

  RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

  buildInputs = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    pkg-config
  ];

  shellHook = ''
    echo "🦀 Rust shell ready"
    exec ${pkgs.zsh}/bin/zsh
  '';
}