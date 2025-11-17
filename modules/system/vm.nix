{ config, pkgs, username, ... }:
{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "${username}" ];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemuSwtpm = true;
    };
  };
  
  environment.systemPackages = with pkgs; [
    qemu                 # System emulator/virtualizer (KVM/QEMU)
    virt-manager         # GUI to manage libvirt VMs
    win-virtio           # Windows VirtIO drivers (paravirt disk/net)
    swtpm                # Software TPM emulator (vTPM for VMs)
    looking-glass-client # Share GPU framebuffer from VM to host (low-latency)
  ];

  users.users.${username}.extraGroups = [ "libvirtd" "kvm" "qemu-libvirtd" ];
}