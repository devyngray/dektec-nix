{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hardware.dektecDTU;
  dektecDTUKmod = pkgs.dektecDTUKmodFor config.boot.kernelPackages;
in
{
  options.hardware.dektecDTU.enable = lib.mkEnableOption "DekTec DTU drivers and userspace";

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [ dektecDTUKmod ];

    boot.kernelModules = [ "Dtu" ];

    services.udev.extraRules = ''
      SUBSYSTEMS=="usb", ATTRS{manufacturer}=="DEKTEC", SYMLINK+="usb/DekTec/%k", MODE="0666"
      SUBSYSTEMS=="usb", ATTRS{manufacturer}=="DekTec", SYMLINK+="usb/DekTec/%k", MODE="0666"
    '';
  };
}
