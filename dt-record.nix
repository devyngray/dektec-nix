{
  lib,
  stdenv,
  fetchzip,
  dektec-linux-sdk,
}:
let
  version = "4.16.1";
in
stdenv.mkDerivation {
  pname = "dt-record";
  inherit version;

  src = fetchzip {
    url = "https://www.dektec.com/products/applications/DtRecord/downloads/DtRecord_v4.16.1.zip";
    sha256 = "sha256-pGiieBTbpaHThnly4bDk2atqwalz5nGuFXb3AluB3ow=";
    stripRoot = false;
  };

  usePostUnpack = true;
  postUnpack = ''
    mkdir -p ./source/Import/DTAPI
    cp ${dektec-linux-sdk}/DTAPI/Include/DTAPI.h ./source/Import/DTAPI/
    cp ${dektec-linux-sdk}/DTAPI/Lib/GCC7.5.0/DTAPI64.o ./source/Import/DTAPI/
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ./DtRecord $out/bin
    chmod +x $out/bin/DtRecord

    runHook postInstall
  '';

  meta = {
    description = "DekTec Command-Line Recorder Tool";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
