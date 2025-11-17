{ ... }:
{
  programs.distrobox = {
    enable = true;
    settings = {
      container_manager = "podman";
    };
  };
}