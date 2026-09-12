{ pkgs, vars, ... }:

pkgs.mkShell {
  name = "opencl-env-shell";

  buildInputs = with pkgs; [
      gcc
      cmake
      clang-tools
      pkg-config
      binutils
      ninja
      gdb
      gdbgui
 
      clinfo
      ocl-icd
      opencl-headers
  ];

  shellHook = ''
    echo "✅OpenCL shell ready"
    export CLI_OpenCLFileName="${pkgs.ocl-icd}/lib/libOpenCL.so.1"
    exec ${pkgs.zsh}/bin/zsh
  '';
}
