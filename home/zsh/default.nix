{ ... }:
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

    envExtra = ''
      export ZSH_DISABLE_COMPFIX=true
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,bold"
      export EDITOR=nvim
    '';
  };
}