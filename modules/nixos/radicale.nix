{ ... }:
{
  services.radicale = {
    enable = true;
    settings =
      let
        path = "/etc/radicale";
      in
      {
        server = {
          hosts = [
            "0.0.0.0:5232"
            "[::]:5232"
          ];
        };
        auth = {
          # pls rember to run htpasswd to generate a password for it
          type = "htpasswd";
          htpasswd_filename = "${path}/users";
          htpasswd_encryption = "autodetect";
        };
      };
  };

  networking.firewall.allowedTCPPorts = [ 5232 ];
}
