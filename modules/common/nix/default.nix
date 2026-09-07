{ outputs, pkgs, lib, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
      permittedInsecurePackages = [ 
        "qtwebengine-5.15.19" 
      ];
    };
    overlays = outputs.overlays;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ]; 
    };
  }
  
  // lib.optionalAttrs pkgs.stdenv.isDarwin {
    enable = false;
  }
  
  // lib.optionalAttrs pkgs.stdenv.isLinux {
    optimise.automatic = true;
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}