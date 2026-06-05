{ pkgs, ... }:

let
  nerdFonts = with pkgs.nerd-fonts; [
    fira-code
    droid-sans-mono
    dejavu-sans-mono
    iosevka
  ];

  standardFonts = with pkgs; [
    fantasque-sans-mono
    material-design-icons
    noto-fonts
    siji
    terminus_font
  ];
in
{
  fonts.packages = nerdFonts ++ standardFonts;
}