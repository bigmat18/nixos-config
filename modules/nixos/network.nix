{ pkgs, lib, ...}:

{
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks = {
     "TIM-32947764" = {
      	psk = "ECtGxGAxFFxHXDKbDexU2YGt";
      };
     "FRITZ!Box 7590 AS" = {
      	psk = "29071995g";
      };
  };
}