{
  description = "DekTec DTU Linux SDK and NixOS kernel module";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlays.default ];
              config.allowUnfree = true;
            };
          in
          f { inherit system pkgs; }
        );
    in
    {
      overlays.default = import ./overlay.nix;

      nixosModules = {
        dektecDTA = import ./modules/dektec-dta.nix;
        dektecDTU = import ./modules/dektec-dtu.nix;
        dektecUserspace = import ./modules/dektec-userspace.nix;
      };

      packages = forAllSystems (
        { pkgs, ... }:
        {
          inherit (pkgs)
            dektecLinuxSDK
            dtInfoCL
            dtPlay
            dtRecord
            dektecDTAKmod
            dektecDTUKmod
            ;
        }
      );
    };
}
