{ config, pkgs, lib, ...}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # autosuggestions.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
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