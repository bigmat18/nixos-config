{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../../system/network.nix
    ../../system/boot.nix
    ../../system/users.nix
  ];

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";
  
  services = {
    xserver = {
      layout = "it";
      xkbVariant = "";
      enable = true;
      autorun = false;
      videoDrivers = [ "amdgpu" ];
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
    git
    pasystray
    picom
    pulseaudioFull
    vim
    unrar
    unzip
    vscode
    rclone
    obsidian
    fastfetch
    htop
    firefox

    networkmanager
    networkmanagerapplet
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
  ];

  programs = {
    thunar.enable = true;
    zsh.enable = true;
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
