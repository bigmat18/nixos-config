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
      xkbVariant = "intl";
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
    flatpak.enable = true;
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
    ranger
    light
    networkmanagerapplet
    dconf
    picom
    pavucontrol
    unrar
    unzip
    rclone
    fastfetch
    htop

    obsidian
    firefox
    smartgit
    vscode
    discord-canary
    
    vulkan-loader
    vulkan-tools
    
    zathura
    mpv

    xclip
    wl-clipboard
    appimage-run

    wget
    via
    bear

    killall
    linuxKernel.packages.linux_zen.perf
    meshlab-unstable
    brightnessctl

    # ==== lstopo command with graphics 
    cairo
    (hwloc.overrideAttrs (old: {
      configureFlags = old.configureFlags or [] ++ [
        "--enable-cairo"
        "--enable-x11"
      ];
      buildInputs = (old.buildInputs or []) ++ [ cairo xorg.libX11 pkg-config ];
    }))

  ];
  # ====================================

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

  programs.zsh.enable = true; # To fix rebuild bug

  security = {
    rtkit.enable = true;   # For audio purposes
    polkit.enable = true;  # Used to control system preferences
  };
  
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true; 
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  
  # Don't touch this
  system.stateVersion = "23.05";
}
