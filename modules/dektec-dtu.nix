{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hardware.dektec-dtu;
in
{
  options.hardware.dektec-dtu.enable = lib.mkEnableOption "DekTec DTU drivers and userspace";

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [ pkgs.dektec-dtu-kmod ];

    boot.kernelModules = [ "Dtu" ];

    # TODO: look into services.udev.extraRules for permissions
  };
}
