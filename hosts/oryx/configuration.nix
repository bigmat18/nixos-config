{
  inputs,
  outputs,
  vars,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

    ./hardware-configuration.nix
    ../../stylix.nix

    ../../modules/nixos/network
    ../../modules/nixos/users
    ../../modules/nixos/nvidia
    ../../modules/nixos/boot
    ../../modules/nixos/pipewire
    ../../modules/nixos/docker
    ../../modules/nixos/game
    ../../modules/nixos/vm
    ../../modules/nixos/bluetooth
    ../../modules/nixos/sonicwall
    ../../modules/nixos/wayland

    ../../modules/common/fonts
    ../../modules/common/nix
    ../../modules/common/nix-scripts
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.username} = {
      imports = [
        ../../home/sway
        ../../home/waybar
        ../../home/rofi

        ../../home/zsh
        ../../home/nvim
        ../../home/tmux
        ../../home/git
        ../../home/yazi
        ../../home/zathura
        ../../home/fastfetch
        ../../home/firefox
        ../../home/alacritty
        ../../home/obs-studio
        ../../home/dust
      ];

      home.stateVersion = "26.05";
      systemd.user.startServices = "sd-switch";
    };
  };

  networking.hostName = "nixbtw";
  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    rtkit.enable = true; # For audio purposes
    polkit.enable = true; # Used to control system preferences
  };

  services = {
    dbus.enable = true;
    gvfs.enable = true;
    tailscale.enable = true;
  };

  programs = {
    direnv.enable = true;
    thunar.enable = true;
    dconf.enable = true;
    nix-ld.enable = true;
    zsh.enable = true; # To fix rebuild bug
    java = {
      enable = true;
      package = pkgs.openjdk;
    };
  };

  environment.systemPackages = with pkgs; [
    python3 # Python interpreter
    dconf # GNOME config backend/CLI
    killall # Kill by process name
    wget # CLI downloader
    zip # ZIP file archiver
    unzip # Unzip ZIP files
    unrar # Extract RAR files
    btop # TUI resource monitor
    htop # Interactive process viewer
    perf # Kernel perf profiler
    nixd # Nix Language Server
    nixpkgs-fmt # Nix Formattater
  ];

  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="pci", ATTR{class}=="0x0c0330", ATTR{power/wakeup}="disabled"
  '';

  # Don't touch this
  system.stateVersion = "23.05";
}
