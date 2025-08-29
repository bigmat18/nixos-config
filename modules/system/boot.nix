{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.resumeDevice = "/dev/disk/by-uuid/67ff953d-726e-4ed1-a1c6-9df7c313f961";
}