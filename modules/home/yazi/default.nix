{ pkgs, ...}:
{
  home.packages = with pkgs; [
    ueberzugpp
    viu
    ffmpegthumbnailer
  ];

  programs.yazi = { 
    enable = true; 
    settings = {
      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };
    };
  };
}