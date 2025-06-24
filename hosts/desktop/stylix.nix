{ nix-config, config, pkgs, inputs, ... }:

let
  fontSize = 11;
  gruvbox = {
    bg           = "#232323";  # Più scuro e meno saturo del classico Gruvbox
    bg_inactive  = "#32302f";  # Inactive background, più soft
    fg           = "#ebdbb2";  # Foreground classico Gruvbox
    gray         = "#a89984";  # Grigio più chiaro per contrasto moderno
    dark         = "#1a1a1a";  # Ancora più scuro per elementi profondi
    blue         = "#7fa2ac";  # Blu desaturato, moderno
    yellow       = "#e0c46c";  # Giallo più soft, meno saturo
    red          = "#ea6962";  # Rosso più caldo e meno acceso
    green        = "#a9b665";  # Verde oliva, meno saturo
    orange       = "#e78a4e";  # Orange soft
    purple       = "#d3869b";  # Viola classico Gruvbox
    aqua         = "#89b482";  # Aqua soft
  };
in
{
  stylix = {
    enable = true;

    colors = {
      base00 = "#232323"; # background
      base01 = "#32302f"; # background highlight
      base02 = "#a89984"; # comments, invisibles, line highlighting
      base03 = "#1a1a1a"; # dark background
      base04 = "#ebdbb2"; # light foreground
      base05 = "#ebdbb2"; # default foreground, caret, delimiters, operators
      base06 = "#e0c46c"; # light background
      base07 = "#e78a4e"; # variables, tags, markup link text, markup lists, diff deleted
      base08 = "#ea6962"; # red
      base09 = "#e78a4e"; # orange
      base0A = "#e0c46c"; # yellow
      base0B = "#a9b665"; # green
      base0C = "#89b482"; # aqua/cyan
      base0D = "#7fa2ac"; # blue
      base0E = "#d3869b"; # purple
      base0F = "#a89984"; # brown/gray
    };

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
      size = 24;
    };

    fonts.sizes = {
      applications = 11;
      desktop = 11;
      popups = 11;
      terminal = 11;
    };
  };
}