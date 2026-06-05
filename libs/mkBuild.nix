{ nixpkgs, vars, path, systems ? [ "x86_64-linux" "aarch64-darwin" ] }: 

let
  forAllSystems = nixpkgs.lib.genAttrs systems;
  mkForSystem = system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      files = builtins.readDir path;
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