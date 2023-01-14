{config, pkgs, lib, ...}:

let
  cfg = config.services.python-validity;
in

with lib;

{
  options = {
    services.python-validity = {
      enable = mkOption {
        default = false;
        type = with types; bool;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.packages = [ pkgs.python-validity ];
    systemd.services.python3-validity.wantedBy = [ "multi-user.target" ];

    # need to register the dbus configuration files of the package, otherwise we will get access errors
    services.dbus.packages = [ pkgs.python-validity ];
  };
}
