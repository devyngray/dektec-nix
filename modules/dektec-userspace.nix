{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.dektecUserspace;
in
{
  options.programs.dektecUserspace.enable = lib.mkEnableOption "DekTec userspace utilities";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.dtInfoCL
      pkgs.dtPlay
    ];
  };
}
