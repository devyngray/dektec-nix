{
  lib,
  stdenv,
  fetchzip,
}:
let
  version = "1.7.1";
in
stdenv.mkDerivation {
  pname = "dt-info-cl";
  inherit version;

  src = fetchzip {
    url = "https://www.dektec.com/products/applications/DtInfoCL/downloads/DtInfoCL_v${version}.zip";
    sha256 = "sha256-+1iVvz19ALTNJpjGTfP73DwExv4/FfrzlQkfsJs0Xks=";
    stripRoot = false;
  };

  dontBuild = true;
  dontFixup = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp ./Linux/DtInfoCL64 $out/DtInfoCL
    chmod +x $out/DtInfoCL

    runHook postInstall
  '';

  meta = {
    description = "DekTec Command-Line Hardware Information Tool";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
