# stylix.nix
{ config, pkgs, ... }:

let
  gruvboxDarkSoft = {
    base00 = "#32302f"; # background
    base01 = "#3c3836";
    base02 = "#504945";
    base03 = "#665c54";
    base04 = "#bdae93";
    base05 = "#d5c4a1"; # foreground
    base06 = "#ebdbb2";
    base07 = "#fbf1c7";
    base08 = "#fb4934"; # red
    base09 = "#fe8019"; # orange
    base0A = "#fabd2f"; # yellow
    base0B = "#b8bb26"; # green
    base0C = "#8ec07c"; # aqua
    base0D = "#83a598"; # blue
    base0E = "#d3869b"; # purple
    base0F = "#d65d0e"; # brown
  };
in
{
  _module.args.colorschema = gruvboxDarkSoft;

  stylix = {
    enable = true;
    base16Scheme = gruvboxDarkSoft;

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