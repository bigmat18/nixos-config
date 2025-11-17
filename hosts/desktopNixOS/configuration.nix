{ config, lib, pkgs, inputs, ... }:
{ 
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/network.nix
    ../../modules/system/users.nix
    ../../modules/system/fonts.nix
    ../../modules/system/nvidia.nix
    ../../modules/system/boot.nix
    ../../modules/system/xserver.nix
    ../../modules/system/substituter.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/docker.nix
    ../../modules/system/game.nix
    ../../modules/system/vm.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/podman.nix
  ];

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    rtkit.enable = true;   # For audio purposes
    polkit.enable = true;  # Used to control system preferences
  };

  services = {
    dbus.enable = true;
    gvfs.enable = true;
  };

  programs = {
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
    unzip        # Unzip ZIP files
    unrar        # Extract RAR files
    xclip        # X11 clipboard CLI
    wl-clipboard # Wayland clipboard (wl-copy/paste)
    btop         # TUI resource monitor
    htop         # Interactive process viewer
    perf         # Kernel perf profiler
  ];

  services.tailscale.enable = true;

  # Don't touch this
  system.stateVersion = "23.05";
}