let
  pkgs = import <nixpkgs> { };

  dektecLinuxSDK = pkgs.callPackage ./dektec-linuxsdk.nix { };
in
{
  inherit dektecLinuxSDK;
}
