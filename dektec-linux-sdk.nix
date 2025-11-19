{
  lib,
  stdenv,
  fetchurl,
}:
let
  version = "2025.09.0";
in
stdenv.mkDerivation {
  pname = "dektec-linux-sdk";
  inherit version;

  src = fetchurl {
    url = "https://www.dektec.com/products/SDK/DTAPI/Downloads/LinuxSDK_v${version}.tar.gz";
    sha256 = "sha256-Vhd2cQjFeCsEhfHT9eDZTqX820psZv1iUlGIwOQB8XM=";
  };

  dontBuild = true;
  dontFixup = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r ./* $out/

    runHook postInstall
  '';

  meta = {
    description = "DekTec Linux SDK";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
