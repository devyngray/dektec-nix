{
  lib,
  stdenv,
  kernel,
  dektec-linux-sdk,
}:
let
  version = dektec-linux-sdk.version;
in
stdenv.mkDerivation {
  pname = "dektec-dta-kmod";
  inherit version;

  src = dektec-linux-sdk;

  nativeBuildInputs = kernel.moduleBuildDependencies;

  KERNELDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  buildPhase = ''
    runHook preBuild

    cd Drivers/Dta/Source/Linux/
    make

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
    cp Dta.ko $out/lib/modules/${kernel.modDirVersion}/extra/

    runHook postInstall
  '';

  meta = {
    description = "DekTec Linux DTA PCIe kernel module for NixOS";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
