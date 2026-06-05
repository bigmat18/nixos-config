{ vars, ... }:
{
  stylix = {
    enable = true;
    image = ./background/nixos.png;
    base16Scheme = vars.colorschema;

    fonts = {
      sizes = {
        applications = 9;
        terminal     = 11;
        desktop      = 9;
        popups       = 11;
      };
    };
  };
}