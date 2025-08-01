{ config, pkgs, lib, ...}:
{ 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      ff = "fastfetch";
    };
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };

    initContent = ''
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,bold"
      export EDITOR=nvim

      update() {
        if [[ -z "$1" ]]; then
          echo "Usage: update <setup-name>"
          return 1
        fi
        sudo nixos-rebuild switch --flake /home/bigmat18/nixos-config#"$1"
      }

      shell() {
        if [[ -z "$1" ]]; then
          echo "Usage: shell <setup-name>"
          return 1
        fi
        nix develop --option sandbox false /home/bigmat18/nixos-config#"$1"
      }

      home() {
        if [[ -z "$1" ]]; then
          echo "Usage: home <setup-name>"
          return 1
        fi
        home-manager switch --flake /home/bigmat18/nixos-config#"$1"
      }

      get() {
        if [[ -z "$1" ]]; then
          echo "Usage: install <package-name>"
          return 1
        fi
        nix shell nixpkgs#"$1"
      }
    '';
  };
}