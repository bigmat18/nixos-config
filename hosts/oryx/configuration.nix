{ 
  inputs,
  outputs,
  vars,
  pkgs,
  ... 
}: { 
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

    ./hardware-configuration.nix
    ../../stylix.nix

    ../../modules/nixos/network
    ../../modules/nixos/users
    ../../modules/nixos/fonts
    ../../modules/nixos/nvidia
    ../../modules/nixos/boot
    ../../modules/nixos/xserver
    ../../modules/nixos/pipewire
    ../../modules/nixos/docker
    ../../modules/nixos/game
    ../../modules/nixos/vm
    ../../modules/nixos/bluetooth
    ../../modules/nixos/nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.username} = { 
      imports = [
        ../../home/i3
        ../../home/i3status
        ../../home/picom
        ../../home/zsh
        ../../home/nvim
        ../../home/tmux
        ../../home/rofi
        ../../home/git
        ../../home/yazi
        ../../home/zathura
        ../../home/fastfetch
        ../../home/firefox
        ../../home/alacritty
        ../../home/obs-studio
        ../../home/dust
        ../../home/connect-tunnel
      ];

      services.i3status = {
        useAlternativeStatusCommand = true;
        activeModules = [ 
          "volume master"  
          "wireless _first_" 
          "cpu_usage" 
          "memory" 
          "load"
          "tztime localtime"
        ];
      };

      home.file = {
        ".xinitrc".source = ../../dotfiles/.xinitrc;
        ".bash_profile".source = ../../dotfiles/.bash_profile;
        ".zprofile".source = ../../dotfiles/.zprofile;
      };

      home.stateVersion = "24.11";
      systemd.user.startServices = "sd-switch";
    };
  };

  networking.hostName = "nixbtw";
  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    rtkit.enable = true;   # For audio purposes
    polkit.enable = true;  # Used to control system preferences
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
    lxsession    # X11 session manager
    python3      # Python interpreter
    xdotool      # Simulate X11 input
    dconf        # GNOME config backend/CLI
    killall      # Kill by process name
    wget         # CLI downloader
    zip          # ZIP file archiver
    unzip        # Unzip ZIP files
    unrar        # Extract RAR files
    xclip        # X11 clipboard CLI
    wl-clipboard # Wayland clipboard (wl-copy/paste)
    btop         # TUI resource monitor
    htop         # Interactive process viewer
    perf         # Kernel perf profiler
    nixd         # Il Language Server
    nixpkgs-fmt  # Formattatore (consigliato per l'integrazione con l'LSP)
  ];

  # Don't touch this
  system.stateVersion = "23.05";
}