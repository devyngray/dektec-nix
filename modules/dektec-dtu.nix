{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hardware.dektec-dtu;
  dektec-dtu-kmod = pkgs.dektec-dtu-kmodFor config.boot.kernelPackages;
in
{
  options.hardware.dektec-dtu.enable = lib.mkEnableOption "DekTec DTU drivers and userspace";

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [ dektec-dtu-kmod ];

    boot.kernelModules = [ "Dtu" ];

    environment.systemPackages = [ pkgs.dt-info-cl ];

    # TODO: look into services.udev.extraRules for permissions
  };
}
