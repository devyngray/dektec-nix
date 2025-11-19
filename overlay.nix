final: prev: {
  dektec-linux-sdk = final.callPackage ./dektec-linux-sdk.nix { };
  dt-info-cl = final.callPackage ./dt-info-cl.nix { };

  dektec-dtu-kmodFor = linuxPackages: linuxPackages.callPackage ./dektec-dtu-kmod.nix { };
  dektec-dtu-kmod = final.dektec-dtu-kmodFor final.linuxPackages;
}
