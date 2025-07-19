{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "sonicWall";
  version = "1.0";

  src = pkgs.fetchurl {
    url = "https://software.sonicwall.com/CT-NX-VPNClients/CT-12.4.3/ConnectTunnel_Linux64-12.43.00311.tar";
    sha256 = "14cqhlqkp5hhi5xkf0bpqqyn0ic9qa8srg8b9chn978y6vi63m6v";
  };

  buildInputs = [ pkgs.gcc pkgs.findutils ];

  unpackPhase = ''
    set -x
    echo "Unpack"
    tar -xf $src 2>&1 | tee /dev/stderr
    rm -rf /usr/local/Aventail 2>&1 | tee /dev/stderr || true
  '';

  buildPhase = ''
    set -x
    echo "Build"
    chmod +x ./install.sh 2>&1 | tee /dev/stderr
    yes | bash ./install.sh --prefix=$out 2>&1 | tee /dev/stderr
  '';

  installPhase = ''
    echo "Succesfull"
  '';

  meta = with pkgs.lib; {
    description = "SonicWall Tunnel";
    license = licenses.mit;
  };
}