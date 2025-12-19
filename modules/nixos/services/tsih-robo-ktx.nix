{
  inputs,
  pkgs,
  config,
  ...
}:
let
  tsih-robo-path = "/srv/tsih-robo-ktx";
in
{
  users.users.tsih = {
    description = "Tsih-robo owner (very cute)";
    home = tsih-robo-path;
    createHome = true;
    isSystemUser = true;
    group = config.users.groups.tsih.name;
    shell = "${pkgs.shadow}/bin/nologin";
  };

  users.groups.tsih.gid = config.users.users.tsih.uid;

  systemd.services = {
    tsih-robo-ktx = {
      unitConfig = {
        Description = "Discord bot mais fofa do mundo!";
        Documentation = [
          "https://github.com/matkijahenkilo/tsih-robo-ktx"
        ];
      };

      serviceConfig = {
        User = config.users.users.tsih.name;
        Group = config.users.users.tsih.group;
        WorkingDirectory = tsih-robo-path;
        ExecStart = "${
          inputs.tsih-robo-ktx.packages.${pkgs.stdenv.hostPlatform.system}.default
        }/bin/tsih-robo-ktx";
        Restart = "on-failure";
        RestartSec = "5s";
      };

      wantedBy = [
        "multi-user.target"
      ];
    };
  };
}
