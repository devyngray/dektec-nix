{
  lib,
  stdenv,
  fetchzip,
  dektecLinuxSDK,
}:
let
  version = "4.19.1";
in
stdenv.mkDerivation {
  pname = "dt-play";
  inherit version;

  src = fetchzip {
    url = "https://www.dektec.com/products/applications/DtPlay/downloads/DtPlay_v${version}.zip";
    sha256 = "sha256-q/nEXZQieBP3QM5QGKWtxMzrNIFnE6DWDQYz1phQeL8=";
    stripRoot = false;
  };

  usePostUnpack = true;
  postUnpack = ''
    mkdir -p ./source/Import/DTAPI
    cp ${dektecLinuxSDK}/DTAPI/Include/DTAPI.h ./source/Import/DTAPI/
    cp ${dektecLinuxSDK}/DTAPI/Lib/GCC7.5.0/DTAPI64.o ./source/Import/DTAPI/
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ./DtPlay $out/bin
    chmod +x $out/bin/DtPlay

    runHook postInstall
  '';

  meta = {
    description = "DekTec Command-Line Hardware Information Tool";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
