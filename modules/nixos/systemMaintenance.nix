{
  config,
  lib,
  ...
}: let
  cfg = config.fuyuNoKosei.systemMaintenance;
in {
  options = {
    fuyuNoKosei.systemMaintenance = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    system = {
      stateVersion = "25.05";
      autoUpgrade = {
        enable = true;
        flags = [
          "--update-input"
          "nixpkgs"
          "-L"
        ];
      };
    };
  };
}
