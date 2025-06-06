{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  HOME = config.home.homeDirectory;
in
{
  home.packages =
    (with pkgs; [
      # File manager
      dolphin
      ark

      # Clipboard
      wl-clipboard

      # Notification
      libnotify
      mako

      # Extra
      blueman

      # Styling
      nwg-look
      libsForQt5.qt5ct
      qt6ct
      breeze-icons

    ])
    ++ [
      # Volume controls
      (pkgs.writeShellScriptBin "script-volume-decrease" ''
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-
        ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga
      '')
      (pkgs.writeShellScriptBin "script-volume-increase" ''
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
        ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga
      '')

      # Screenshots
      (pkgs.writeShellScriptBin "script-screenshot" ''
        FILE_NAME="screenshot-$(date +%F_%H-%M-%S).png"
        FILE_PATH="${HOME}/Pictures/screenshots/$FILE_NAME"
        ${pkgs.grim}/bin/grim -t png "$FILE_PATH"
        if [[ $? != 0 ]]; then
          ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/dialog-error.oga
          exit 1
        fi
        wl-copy < $FILE_PATH
        notify-send 'Screenshot' -i "$FILE_PATH" "$FILE_NAME"
        ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/screen-capture.oga
      '')
      (pkgs.writeShellScriptBin "script-screenshot-selection" ''
        FILE_NAME="screenshot-$(date +%F_%H-%M-%S).png"
        FILE_PATH="${HOME}/Pictures/screenshots/$FILE_NAME"
        ${pkgs.grim}/bin/grim -t png -g "$(${pkgs.slurp}/bin/slurp)" "$FILE_PATH"
        if [[ $? != 0 ]]; then
          ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/dialog-error.oga
          exit 1
        fi
        wl-copy < $FILE_PATH
        notify-send 'Screenshot' -i "$FILE_PATH" "$FILE_NAME"
        ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/screen-capture.oga 
      '')
    ];

  programs = {
    wofi.enable = true;
    hyprlock = {
      enable = true;
      settings = {
        background = {
          path = lib.mkDefault "screenshot";
          blur_passes = 3;
          blur_size = 8;
        };

        label = {
          text = "(∩´∀｀)∩";
          text_align = "center";
          font_size = 35;
          position = "0, 80";
          halign = "center";
          valign = "center";
        };

        input-field = {
          size = "200, 50";
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = false;
          dots_rounding = -1;
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          rounding = -1;
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 300;
          capslock_color = -1;
          numlock_color = -1;
          bothlock_color = -1;
          invert_numlock = false;
          swap_font_color = false;
          position = "0, -20";
          halign = "center";
          valign = "center";
        };
      };
    };
  };

  xdg.configFile."waylogout/config".text = ''
    fade-in=1
    poweroff-command="poweroff"
    reboot-command="reboot"
    default-action="poweroff"
    screenshots
    effect-blur=7x5
    indicator-thickness=20
    ring-color=888888aa
    inside-color=88888866
    text-color=eaeaeaaa
    line-color=00000000
    ring-selection-color=33cc33aa
    inside-selection-color=33cc3366
    text-selection-color=eaeaeaaa
    line-selection-color=00000000
    selection-label
  '';

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
  systemd.user.services.cliphist.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];
  systemd.user.services.cliphist-images.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];

  services.wlsunset = {
    enable = true;
    temperature = {
      day = 6500;
      night = 2700;
    };
    sunrise = "06:00";
    sunset = "19:00";
  };
  systemd.user.services.wlsunset.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];

  services = {
    playerctld.enable = true;
    mako = {
      enable = true;
      actions = true;
      anchor = "top-right";
      icons = true;
      defaultTimeout = 7000; # 7s
      ignoreTimeout = true;
    };
    hyprpaper = {
      enable = true;
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
            on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
          }
          {
            timeout = 270;
            on-timeout = "${pkgs.libnotify}/bin/notify-send 'Hypridle' 'Idling in 30 seconds.'";
          }
          {
            timeout = 300;
            on-timeout = "hyprlock";
            on-resume = "${pkgs.libnotify}/bin/notify-send 'Welcome back!'";
          }
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };

  imports = [
    inputs.wayland-pipewire-idle-inhibit.homeModules.default
  ];
  services.wayland-pipewire-idle-inhibit = {
    enable = true;
    settings = {
      verbosity = "INFO";
      media_minimum_duration = 10;
      node_blacklist = [
        { name = "spotify"; }
        { app_name = "Music Player Daemon"; }
      ];
    };
  };
  systemd.user.services.wayland-pipewire-idle-inhibit.Install.WantedBy = lib.mkForce [
    "hyprland-session.target"
  ];
}
