{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../../system/network.nix
    ../../system/users.nix
  ];

  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "it_IT.UTF-8";

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
      xkbOptions = "compose:ralt";
      enable = true;
      autorun = false;
      videoDrivers = [ "nvidia" ];
      windowManager.i3 = {
        enable = true;
      };
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager = {
	      startx.enable = true;
	      lightdm.enable = lib.mkForce false;
        defaultSession = "none+i3";
      };
      libinput.enable = true;
    };
    gvfs.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
   
  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    networkmanagerapplet
    pasystray
    picom
    pulseaudioFull
    pavucontrol
    vim
    unrar
    unzip
    rclone
    obsidian
    fastfetch
    htop
    firefox
    
    vscode
    
    discord
    spotify
    mpv

    xclip
    wl-clipboard
    appimage-run

    wget
    via
  ];

  programs.light.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
  ];

  programs = {
    thunar.enable = true;
    zsh.enable = true;
    dconf.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  
  hardware = {
    bluetooth.enable = true;
  };
  
  # Don't touch this
  system.stateVersion = "23.05";
}
