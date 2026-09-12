rec {
  fullName = "Matteo Giuntoni";
  username = "bigmat18";
  email = "mat.giu2002@gmail.com";
  configDir = "/home/${username}/nixos-config";

  gruvbox-v1 = {
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

  gruvbox-v2 = {
    base00 = "#32302f"; # Default Background
    base01 = "#4b4441"; # Lighter Background (Status bars, line numbers)
    base02 = "#5e5551"; # Selection Background
    base03 = "#756a65"; # Comments, Invisibles, Line Highlighting
    base04 = "#bdae93"; # Dark Foreground (UI elements)
    base05 = "#d4be9a"; # Default Foreground, Text, Caret
    base06 = "#e2d7c4"; # Light Foreground (Not often used)
    base07 = "#f0ebd9"; # Lightest Background
    base08 = "#d8a65c"; # Variables, XML Tags, Markup Link Text
    base09 = "#d8a65c"; # Integers, Boolean, Constants, XML Attributes
    base0A = "#d8a65c"; # Classes, Search Text, Markup Bold, Types
    base0B = "#8c945c"; # Strings, Inherited Class, Markup Code, Git Added
    base0C = "#8c945c"; # Support, Regular Expressions, Escape Characters, Git Changed
    base0D = "#8c945c"; # Functions, Methods, Attribute IDs, Headings
    base0E = "#d8a65c"; # Keywords, Storage, Selector, Markup Italic
    base0F = "#4b4441"; # Deprecated, Opening/Closing Embedded Language Tags
  };

  colorscheme = gruvbox-v1;
}
