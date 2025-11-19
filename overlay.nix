final: prev: {
  dektec-linux-sdk = final.callPackage ./dektec-linux-sdk.nix { };
  dektec-dtu-kmod = final.linuxPackages.callPackage ./dektec-dtu-kmod.nix { };
}
