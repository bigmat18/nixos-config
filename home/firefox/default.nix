{ vars, ... }:

{
  stylix.targets.firefox.profileNames = [ "${vars.username}" ];
  programs.firefox = {
    enable = true;
    profiles.${vars.username} = {
      path = "sryda9m2.default";
    };
  };
}
