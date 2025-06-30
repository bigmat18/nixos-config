{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.iosevka

    fantasque-sans-mono
    noto-fonts
    terminus_font
    material-design-icons
    siji
  ];
}