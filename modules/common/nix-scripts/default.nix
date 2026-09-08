{ pkgs, vars, ... }:
let

  update = pkgs.writeShellScriptBin "update" ''
    if [[ -z "$1" ]]; then
      echo "Use: update <setup-name>"
      exit 1
    fi
    target="$1"
    shift
    if [[ "$(uname)" == "Darwin" ]]; then
      sudo darwin-rebuild switch --flake "${vars.configDir}#$target" "$@"
    else
      sudo nixos-rebuild switch --flake "${vars.configDir}#$target" "$@"
    fi  '';

  shell = pkgs.writeShellScriptBin "shell" ''
    if [[ -z "$1" ]]; then
      echo "Use: shell <setup-name>"
      exit 1
    fi
    nix develop --option sandbox false "${vars.configDir}#$1"
  '';

  home-switch = pkgs.writeShellScriptBin "home" ''
    if [[ -z "$1" ]]; then
      echo "Use: home <setup-name>"
      exit 1
    fi
    shift
    home-manager switch --flake "${vars.configDir}#$1" "$@"
  '';

  get = pkgs.writeShellScriptBin "get" ''
    if [[ -z "$1" ]]; then
      echo "Use: get <package-name>"
      exit 1
    fi
    nix shell nixpkgs#"$1"
  '';

in
{
  environment.systemPackages = [
    update
    shell
    home-switch
    get
  ];
}
