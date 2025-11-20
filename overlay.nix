final: prev: {
  dektec-linux-sdk = final.callPackage ./dektec-linux-sdk.nix { };
  dt-info-cl = final.callPackage ./dt-info-cl.nix { };
  dt-play = final.callPackage ./dt-play.nix { };

  dektec-dtu-kmodFor = linuxPackages: linuxPackages.callPackage ./dektec-dtu-kmod.nix { };
  dektec-dtu-kmod = final.dektec-dtu-kmodFor final.linuxPackages;

  dektec-dta-kmodFor = linuxPackages: linuxPackages.callPackage ./dektec-dta-kmod.nix { };
  dektec-dta-kmod = final.dektec-dta-kmodFor final.linuxPackages;
}
