{ pkgs, ... }:
{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  programs.gamemode.enable = true;

programs.gamescope = {
    enable = true;
    capSysNice = true; # Permette a Gamescope di gestire scheduling e input senza drop di frame
  };

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-ng
  ];
  
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
