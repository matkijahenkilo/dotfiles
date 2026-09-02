{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    zabbix.agent.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    zabbix.web.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    services = {
      zabbixAgent = lib.mkIf config.zabbix.agent.enable {
        enable = true;
        server = "localhost,gamma"; # requires both localhost and machine's actual ip.
        # test with `nix shell nixpkgs#zabbix.agent -c zabbix_get -s local-or-remote-ip -k 'service.state[serviceName.service]'`
        settings.UserParameter = [
          "service.state[*],systemctl is-active \"$1\" || true"
        ];
      };

      /*
        setting the server up to trigger certain events for my needs
        was truly an experience that I will forget after 1 day of
        setting this up.

        0. fetch a Discord's webhook beforehand

        1. set up a Macro exactly like this:
           {$ZABBIX.URL} http://zabbix.local

        2. download media_discord.yaml for the current zabbix's version
           https://www.zabbix.com/integrations/discord

        3. import it in Media types

        4. create a user capable of reading a host
           and under the user's Media, add the discord webhook

        5. go to Configuration -> Hosts tab, create an Item as Zabbix agent type
           and `service.state[serviceName.service]` key

        6. create a trigger for the systemd service in Trigger tab
           `last(/pi/service.state[serviceName.service])<>"active"`

        7. uhhhhhhhh I'm already forgetting about the rest

        8. oh right

        9. Configuration -> Actions -> Trigger actions, create new trigger related
           to discord webhooks and add the conditions for the trigger from step 6 as "equals"
           then in the same window, in Operations tab, add an Operation to send
           to the user you created in step 4, set to send only to your Discord media
           you imported in step 3

        10. it should be done now, I guess lol
      */
      zabbixServer = lib.mkIf config.zabbix.web.enable {
        enable = true;
      };

      zabbixWeb = lib.mkIf config.zabbix.web.enable {
        enable = true;
        frontend = "nginx";
        hostname = "zabbix.local";
        nginx.virtualHost.default = true;
      };

      # workaround to fix webui full of errors.
      # syntax has to stay like this, otherwise
      # it will complain that the option was touched
      # and will require additional option setups
      phpfpm.pools.zabbix = lib.mkIf config.zabbix.web.enable {
        phpPackage = pkgs.php83;
      };
    };

    systemd.services.zabbix-server.path = [ pkgs.iputils ];

    networking.firewall.allowedTCPPorts = [ 10050 ];
  };
}
