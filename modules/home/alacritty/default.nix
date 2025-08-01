{ colorschema, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = colorschema.base00;
          foreground = colorschema.base05;
        };
        normal = {
          black   = colorschema.base00;
          red     = colorschema.base08;
          green   = colorschema.base0B;
          yellow  = colorschema.base0A;
          blue    = colorschema.base0D;
          magenta = colorschema.base0E;
          cyan    = colorschema.base0C;
          white   = colorschema.base05;
        };
        bright = {
          black   = colorschema.base03;
          red     = colorschema.base08;
          green   = colorschema.base0B;
          yellow  = colorschema.base0A;
          blue    = colorschema.base0D;
          magenta = colorschema.base0E;
          cyan    = colorschema.base0C;
          white   = colorschema.base07;
        };
      };
    };
  };
}