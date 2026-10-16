{ vars, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/ALLqk82.png";
      hash = "sha256-6BsRfgh0+3Da1oPD1Hgw74q+6CtLVMfoxa1jX9K7pOo=";
    };
    base16Scheme = vars.colorscheme;

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
