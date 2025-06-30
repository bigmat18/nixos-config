{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system/network.nix
    ../../system/users.nix
    ../../system/fonts.nix
    ../../system/nvidia.nix
    ../../system/boot.nix
  ];

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "it_IT.UTF-8";

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "intl";
      xkbOptions = "compose:ralt";
      enable = true;
      autorun = false;
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
      cudaSupport = true;
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
    pulseaudio # Here to audio mix

    obsidian
    firefox
    smartgit
    vscode
    discord-canary
    
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
    ripgrep

    # ==== lstopo command with graphics ==== 
    cairo
    (hwloc.overrideAttrs (old: {
      configureFlags = old.configureFlags or [] ++ [
        "--enable-cairo"
        "--enable-x11"
      ];
      buildInputs = (old.buildInputs or []) ++ [ cairo xorg.libX11 pkg-config ];
    }))
    # ==== lstopo command with graphics ====
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

  virtualisation.docker = {
    enable = true;
  };

  # Don't touch this
  system.stateVersion = "23.05";
}
