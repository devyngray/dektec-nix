{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.dektec-userspace;
in
{
  options.programs.dektec-userspace.enable = lib.mkEnableOption "DekTec userspace utilities";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.dt-info-cl
      pkgs.dt-play
    ];
  };
}
