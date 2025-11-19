{
  lib,
  stdenv,
  kernel,
  dektec-linux-sdk,
  helix,
  breakpointHook,
}:
let
  version = dektec-linux-sdk.version;
in
stdenv.mkDerivation {
  pname = "dektec-dtu-kmod";
  inherit version;

  src = dektec-linux-sdk;

  nativeBuildInputs = kernel.moduleBuildDependencies ++ [
    helix
    breakpointHook
  ];

  KERNELDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  buildPhase = ''
    runHook preBuild

    cd Drivers/Dtu/Source/Linux/
    make

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
    cp Dtu.ko $out/lib/modules/${kernel.modDirVersion}/extra/

    runHook postInstall
  '';

  meta = {
    description = "DekTec Linux DTU USB kernel module for NixOS";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
