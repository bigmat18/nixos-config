{ vars, path }: 
let
  files = if builtins.pathExists path then builtins.readDir path else {};
  nixFiles = builtins.filter (name: 
    files.${name} == "regular" && builtins.match ".*\\.nix" name != null
  ) (builtins.attrNames files);
in
  map (fileName: import (path + "/${fileName}")) nixFiles