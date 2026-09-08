{ nixpkgs, vars, path, systems ? [ "x86_64-linux" "aarch64-darwin" ] }: 

let
  forAllSystems = nixpkgs.lib.genAttrs systems;
  mkForSystem = system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      files = if builtins.pathExists path then builtins.readDir path else {};
      nixFiles = builtins.filter (name: 
        files.${name} == "regular" && builtins.match ".*\\.nix" name != null
      ) (builtins.attrNames files);
    in
      builtins.listToAttrs (map (fileName: {
        name = builtins.replaceStrings [".nix"] [""] fileName;
        value = pkgs.callPackage (path + "/${fileName}") { inherit vars; };
      }) nixFiles);

in
  forAllSystems mkForSystem
