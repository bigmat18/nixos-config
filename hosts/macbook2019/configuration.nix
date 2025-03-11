{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../../system/network.nix
    ../../system/boot.nix
    ../../system/users.nix
  ];

  # edit as per your location and timezone
  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "it_IT.UTF-8";

  services = {
    xserver = {
      layout = "it";
      xkbVariant = "";
      enable = true;
      autorun = false;
      videoDrivers = [ "amdgpu" ];
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
        ];
      };
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = false;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager = {
	      startx.enable = true;
	      lightdm.enable = lib.mkForce false;
          defaultSession = "none+i3";
        };
        libinput = {
      	  enable = true;
        };
    };
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
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
    alacritty
    dmenu
    git
    networkmanagerapplet
    nitrogen
    pasystray
    picom
    pulseaudioFull
    rofi
    vim
    unrar
    unzip
    vscode
    rclone
    obsidian
    fastfetch
    htop

    xorg.xbacklight
    brightnessctl
  ];

  programs.light.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
  ];

  programs = {
    thunar.enable = true;
    firefox.enable = true;
  };

  security = {
    rtkit.enable = true;
  };
  
  hardware = {
    bluetooth.enable = true;
  };

  # Don't touch this
  system.stateVersion = "23.05";
}
