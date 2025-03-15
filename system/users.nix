{ pkgs, ... }:

{
    users.users.bigmat18 = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "jackaudio" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
}