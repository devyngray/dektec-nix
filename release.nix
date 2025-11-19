let
  overlay = import ./overlay.nix;

  pkgs = import <nixpkgs> {
    overlays = [ overlay ];
  };
in
{
  inherit (pkgs) dektec-linux-sdk dektec-dtu-kmod;

  inherit overlay;

  nixosModules = {
    dektec-dtu = import ./modules/dektec-dtu.nix;
  };
}
