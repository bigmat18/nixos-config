{ config, pkgs, lib, ...}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # autosuggestions.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch /home/bigmat18/nixos-config#desktop";
      cuda = "nix develop /home/bigmat18/nixos-config#cuda";
      mpi = "nix develop /home/bigmat18/nixos-config#mpi";
      default = "nix develop /home/bigmat18/nixos-config";
    };
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    initExtra = ''
      # Configurazioni extra
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,bold"
      export EDITOR=vim
    '';
  };
}