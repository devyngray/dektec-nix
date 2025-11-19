final: prev: {
  dektec-linux-sdk = final.callPackage ./dektec-linux-sdk.nix { };
  dt-info-cl = final.callPackage ./dt-info-cl.nix { };
  dektec-dtu-kmod = final.linuxPackages.callPackage ./dektec-dtu-kmod.nix { };
}
