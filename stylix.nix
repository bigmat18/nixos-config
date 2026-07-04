{ vars, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
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

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVuSansM Nerd Font";
      };

      emoji = {
        package = if isDarwin then pkgs.emptyDirectory else pkgs.noto-fonts-color-emoji;
        name = if isDarwin then "Apple Color Emoji" else "Noto Color Emoji";
      };
    };
  };
}