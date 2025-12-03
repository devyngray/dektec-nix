final: prev: {
  dektecLinuxSDK = final.callPackage ./dektec-linux-sdk.nix { };
  dtInfoCL = final.callPackage ./dt-info-cl.nix { };
  dtPlay = final.callPackage ./dt-play.nix { };
  dtRecord = final.callPackage ./dt-record.nix { };

  dektecDTAKmodFor = linuxPackages: linuxPackages.callPackage ./dektec-dta-kmod.nix { };
  dektecDTAKmod = final.dektecDTAKmodFor final.linuxPackages;

  dektecDTUKmodFor = linuxPackages: linuxPackages.callPackage ./dektec-dtu-kmod.nix { };
  dektecDTUKmod = final.dektecDTUKmodFor final.linuxPackages;
}
