{ config, pkgs, ... }:
{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["bigmat18"];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemuSwtpm = true;
    };
  };
  
  environment.systemPackages = with pkgs; [ 
    qemu 
    virt-manager 
    win-virtio 
    swtpm
    looking-glass-client
  ];
}