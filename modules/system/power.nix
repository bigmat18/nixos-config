{
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

  

  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';

  powerManagement.cpuFreqGovernor = "powersave";
}