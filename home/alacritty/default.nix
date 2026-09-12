{ vars, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = vars.colorscheme.base00;
          foreground = vars.colorscheme.base05;
        };
        normal = {
          black   = vars.colorscheme.base00;
          red     = vars.colorscheme.base08;
          green   = vars.colorscheme.base0B;
          yellow  = vars.colorscheme.base0A;
          blue    = vars.colorscheme.base0D;
          magenta = vars.colorscheme.base0E;
          cyan    = vars.colorscheme.base0C;
          white   = vars.colorscheme.base05;
        };
        bright = {
          black   = vars.colorscheme.base03;
          red     = vars.colorscheme.base08;
          green   = vars.colorscheme.base0B;
          yellow  = vars.colorscheme.base0A;
          blue    = vars.colorscheme.base0D;
          magenta = vars.colorscheme.base0E;
          cyan    = vars.colorscheme.base0C;
          white   = vars.colorscheme.base07;
        };
      };
    };
  };
}