{ vars, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = vars.colorschema.base00;
          foreground = vars.colorschema.base05;
        };
        normal = {
          black   = vars.colorschema.base00;
          red     = vars.colorschema.base08;
          green   = vars.colorschema.base0B;
          yellow  = vars.colorschema.base0A;
          blue    = vars.colorschema.base0D;
          magenta = vars.colorschema.base0E;
          cyan    = vars.colorschema.base0C;
          white   = vars.colorschema.base05;
        };
        bright = {
          black   = vars.colorschema.base03;
          red     = vars.colorschema.base08;
          green   = vars.colorschema.base0B;
          yellow  = vars.colorschema.base0A;
          blue    = vars.colorschema.base0D;
          magenta = vars.colorschema.base0E;
          cyan    = vars.colorschema.base0C;
          white   = vars.colorschema.base07;
        };
      };
    };
  };
}