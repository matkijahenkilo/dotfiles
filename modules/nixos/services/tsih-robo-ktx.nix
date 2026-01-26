{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
let
  tsih-robo-path = "/srv/tsih-robo-ktx";
  runScript = pkgs.writeShellScript "runTsihRoboScript" ''
    if [ -f "tsih-robo-ktx.jar" ]; then
      echo "Running from JAR file"
      exec ${lib.getExe pkgs.jre} -jar tsih-robo-ktx.jar
    else
      echo "Running from derivation"
      exec ${inputs.tsih-robo-ktx.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/tsih-robo-ktx
    fi
  '';
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
        ExecStart = "${runScript}";
        Restart = "on-failure";
        RestartSec = "5s";
      };

      wantedBy = [
        "multi-user.target"
      ];
    };
  };
}
