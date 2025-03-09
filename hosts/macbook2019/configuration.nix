{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ../../modules/nixos/network.nix

    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # paste your boot config here...
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.extraModprobeConfig = ''
      options hid-appletb-kbd mode=2
  '';

  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation (final: {
     	name = "brcm-firmware";
      src = ../../firmware/brcm;
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        cp ${final.src}/* "$out/lib/firmware/brcm"
      '';
    }))
  ];

  # edit as per your location and timezone
  time.timeZone = "Europe/Rome";
  i18n = {
    defaultLocale = "it_IT.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "it_IT.UTF-8";
      LC_IDENTIFICATION = "it_IT.UTF-8";
      LC_MEASUREMENT = "it_IT.UTF-8";
      LC_MONETARY = "it_IT.UTF-8";
      LC_NAME = "it_IT.UTF-8";
      LC_NUMERIC = "it_IT.UTF-8";
      LC_PAPER = "it_IT.UTF-8";
      LC_TELEPHONE = "it_IT.UTF-8";
      LC_TIME = "it_IT.UTF-8";
      LC_CTYPE="en_US.utf8"; # required by dmenu don't change this
    };
  };

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
    jack = {
      jackd.enable = true;
    };
  };

   
  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  users.users.bigmat18 = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "jackaudio" ];
    packages = with pkgs; [
      brave
      xarchiver
    ];
  };

  home-manager = {
    users = {
      "bigmat18" = import ./home.nix;
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    dmenu
    git
    gnome-keyring
    networkmanagerapplet
    nitrogen
    pasystray
    picom
    polkit_gnome
    pulseaudioFull
    rofi
    vim
    unrar
    unzip
    vscode
  ];

  programs = {
    thunar.enable = true;
    dconf.enable = true;
    firefox.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  
  hardware = {
    bluetooth.enable = true;
  };

  # Don't touch this
  system.stateVersion = "23.05";
}
