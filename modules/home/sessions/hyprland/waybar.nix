{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        "layer" = "top";
        "position" = "top";
        "spacing" = 0;
        "height" = 44;
        "modules-left" = [
          "custom/logo"
          "hyprland/workspaces"
        ];
        "modules-center" = [
          "clock"
        ];
        "modules-right" = [
          "tray"
          "network"
          "memory"
          "pulseaudio"
          "backlight"
          "battery"
          "custom/power"
        ];
        "wlr/taskbar" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "on-click-right" = "fullscreen";
          "icon-theme" = "WhiteSur";
          "icon-size" = 25;
          "tooltip-format" = "{title}";
        };
        "hyprland/workspaces" = {
          "on-click" = "activate";
          "format" = "{icon}";
          "format-icons" = {
            "default" = "";
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
            "active" = "(˵ •̀ ᴗ - ˵ ) ✧";
            "urgent" = "( ｡ •̀ ᴖ •́ ｡)";
          };
          "persistent_workspaces" = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
        };
        "memory" = {
          "interval" = 5;
          "format" = "󰍛 {}%";
          "max-length" = 10;
        };
        "tray" = {
          "spacing" = 10;
        };
        "clock" = {
          "tooltip-format" = "<tt>{calendar}</tt>";
          "format" = "　{:%a, %d %b %Y ・ %I:%M %p}　なのら~";
        };
        "network" = {
          "format-wifi" = "{icon}";
          "format-icons" = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          "format-ethernet" = "󰀂";
          "format-disconnected" = "󰖪";
          "tooltip-format-wifi" = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-ethernet" = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          "tooltip-format-disconnected" = "Disconnected";
          "interval" = 5;
          "nospacing" = 1;
        };
        "pulseaudio" = {
          "format" = "{icon}  {volume}%";
          "format-bluetooth" = "󰂰";
          "nospacing" = 1;
          "tooltip-format" = "Volume  = {volume}%";
          "format-muted" = "󰝟";
          "format-icons" = {
            "headphone" = "";
            "default" = [
              "󰖀"
              "󰕾"
              ""
            ];
          };
          "on-click" = "pavucontrol";
          "scroll-step" = 1;
        };
        "custom/logo" = {
          "format" = " ᗜ˰ᗜ ";
          "tooltip" = false;
        };
        "backlight" = {
          "format" = "{icon} {percent}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "battery" = {
          "format" = "{capacity}% {icon}";
          "format-icons" = {
            "charging" = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            "default" = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          "format-full" = "Charged ";
          "interval" = 5;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "tooltip" = false;
        };
        "custom/power" = {
          "format" = "󰤆";
          "tooltip" = false;
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: Material Design Icons, JetBrainsMono Nerd Font;
        font-size: 14px;
      }

      window#waybar {
        background-color: rgba(37, 20, 20, 0.8);
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      window#waybar.hidden {
        opacity: 0.5;
      }

      #workspaces {
        background-color: transparent;
      }

      #workspaces button {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
        padding: 6px 18px;
        margin: 6px 3px;
        border-radius: 4px;
        background-color: #2e1e1e;
        color: #dd6666;
      }

      #workspaces button.active {
        color: #2e1e1e;
        background-color: #dd6666;
      }

      #workspaces button:hover {
      box-shadow: inherit;
      text-shadow: inherit;
      color: #2e1e1e;
      background-color: #aa2222;
      }

      #workspaces button.urgent {
        background-color: #ff4040;
      }

      #memory,
      #custom-power,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #tray {
        border-radius: 4px;
        margin: 6px 3px;
        padding: 6px 12px;
        background-color: #2e1e1e;
        color: #251818;
      }

      #custom-power {
        margin-right: 6px;
      }

      #custom-logo {
        padding-right: 7px;
        padding-left: 7px;
        margin-left: 5px;
        font-size: 15px;
        border-radius: 8px 0px 0px 8px;
        color: #931741;
      }

      #memory {
        background-color: #fab387;
      }
      #battery {
        background-color: #f38ba8;
      }
      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
      }

      #battery.warning,
      #battery.critical,
      #battery.urgent {
        background-color: #ff0048;
        color: #181825;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #battery.charging {
        background-color: #d67371;
      }

      #backlight {
        background-color: #fab387;
      }

      #pulseaudio {
        background-color: #f9e2af;
      }

      #network {
        background-color: #bd7462;
        padding-right: 17px;
      }

      #clock {
        font-family: JetBrainsMono Nerd Font;
        background-color: #dd5555;
      }

      #custom-power {
        background-color: #f2adad;
      }


      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #221813;
      }

      tooltip label {
        padding: 5px;
        background-color: #221813;
      }
    '';
  };
}
