{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hardware.dektecDTA;
  dektecDTAKmod = pkgs.dektecDTAKmodFor config.boot.kernelPackages;
in
{
  options.hardware.dektecDTA.enable = lib.mkEnableOption "DekTec DTA kernel module";

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [ dektecDTAKmod ];

    boot.kernelModules = [ "Dta" ];

    services.udev.extraRules = ''
      KERNEL=="Dta*", MODE="0666"
      SUBSYSTEMS=="usb", KERNEL=="ttyUSB[0-9]*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="83d8", MODE="0666", SYMLINK+="DtaPlus%n"
    '';
  };
}
