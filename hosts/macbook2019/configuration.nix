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

    brightnessctl
    powertop
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

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "wifi bluetooth";
      DISK_DEVICES = "nvme0n1";
      DISK_APM_LEVEL_ON_BAT = "128";
      DISK_APM_LEVEL_ON_AC = "254";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_ON_AC = "on";
      USB_AUTOSUSPEND = 1;
      PCIE_ASPM_ON_BAT = "powersave";
      PCIE_ASPM_ON_AC = "performance";
      RUNTIME_PM_DRIVER_BLACKLIST = "amdgpu";
    };
  };

  systemd.services.auto-cpufreq = {
    enable = true;
    script = "${pkgs.auto-cpufreq}/bin/auto-cpufreq --daemon";
    wantedBy = [ "multi-user.target" ];
  };

  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';

  powerManagement.cpuFreqGovernor = "powersave";
}
