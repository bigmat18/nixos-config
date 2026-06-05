{ vars, pkgs, ... }:
{
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/AngelJumbo/gruvbox-wallpapers/refs/heads/main/wallpapers/brands/nixos.png";
      hash = "sha256-M4Q5/Sm5ZVOe324V9pEF9497M0VpcQMPTJHOwW2ZQmg=";
    };
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