{ lib, fetchFromGitHub, buildNimPackage, xorg, libGL }:

buildNimPackage rec {
  pname = "boomer";
  version = "nixos-25.11";

  src = fetchFromGitHub {
    owner = "tsoding";
    repo = "boomer";
    rev = "97189f7";
    hash = "sha256-GxrPoDU1vj0SGuji/vinRu7WThY/J7LTdIdrOG4WOwo="; 
  };

  buildInputs = [
    xorg.libX11
    xorg.libXrandr
    xorg.libXext
    libGL
  ];

  meta = with lib; {
    description = "Zoomer application for Linux by tsoding";
    homepage = "https://github.com/tsoding/boomer";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "boomer";
  };
}