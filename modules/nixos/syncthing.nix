{
  config,
  lib,
  ...
}: let
  cfg = config.fuyuNoKosei.services;
in {
  options = {
    fuyuNoKosei.services = {
      enable = lib.mkEnableOption "syncthing";
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      syncthing = lib.mkIf cfg.syncthing.enable {
        settings = {
          enable = true;
          openDefaultPorts = true;
          # TODO: decide where folders get specified (user-config?)
        };
      };
    };
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  };
}
