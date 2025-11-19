let
  pkgs = import <nixpkgs> {
    overlays = [
      (import ./overlay.nix)
    ];
  };
in
{
  inherit (pkgs) dektec-linux-sdk dektec-dtu-kmod;
}
