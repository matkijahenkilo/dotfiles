{ pkgs, lib, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [
        ",preferred,auto,1"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        layout = "dwindle";
      };
      decoration = {
        rounding = 5;
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        blur = {
          enabled = "yes";
          size = 7;
          passes = 4;
          new_optimizations = true;
        };
      };
      input = {
        kb_layout = "br";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };
      misc = {
        new_window_takes_over_fullscreen = 1;
      };

      exec-once = [
        "hyprpaper"
        "waybar"
        "mako"
        "hypridle"
        "fcitx5"
        "blueman-tray"
      ];

      "$mainMod" = "SUPER";
      bind = [  
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, Return, exec, kitty"
        "$mainMod SHIFT, C, killactive, "
        # "$mainMod SHIFT, Q, exec, wlogout -p layer-shell"
        "$mainMod SHIFT, Q, exit, "
        "$mainMod, F, fullscreen, 0"
        "$mainMod, G, togglegroup, "
        "CTRL SHIFT, 3, exec, $HOME/.config/hypr/scripts/screenshot.sh"
        "CTRL SHIFT, 2, exec, $HOME/.config/hypr/scripts/screenshot-selection.sh"
        "$mainMod, tab, togglespecialworkspace"
        "$mainMod SHIFT, N, exec, kitty -e nvim"
        "$mainMod SHIFT, tab, movetoworkspace, special"
        "$mainMod SHIFT, X, movetoworkspace, 1"
        "$mainMod, backslash, exec, kitty -e ranger"
        "$mainMod, E, exec, thunar"
        "$mainMod, V, togglefloating, "
        # "$mainMod, R, exec, rofi --show drun"
        # "$mainMod, D, exec, $HOME/.config/rofi/launcher.sh"
        "$mainMod, P, exec, rofi -show run"
        "$mainMod, S, togglesplit"

        # Move focus and windows almost like awesomewm
        # "$mainMod, l, movefocus, l"
        # "$mainMod, h, movefocus, r"
        "$mainMod, k, cyclenext"
        "$mainMod, j, cyclenext, prev"
        "$mainMod SHIFT, K, swapwindow, u"
        "$mainMod SHIFT, J, swapwindow, d"
        "$mainMod SHIFT, l, swapwindow, r"
        "$mainMod SHIFT, h, swapwindow, l"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      binde = [
        ", XF86AudioRaiseVolume, exec, volume-increase"
        ", XF86AudioLowerVolume, exec, volume-decrease"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
      ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindl = [
        ", switch:Lid Switch, exec, hyprlock"
      ];
      windowrulev2 = [
        "float,class:^(Lxappearance)$"
        "float,class:^(nwg-look)$"
        "float,class:^(dolphin)$"
        "float,class:^(org.telegram.desktop|vlc)$"
        "float,class:^(galculator)$"
        "float,opacity 0.8 0.8,title:^(Open Files|ranger)"
        "float,class:^(obs)$"
        "float,opacity 0.8 0.8,class:^(thunar)$"
        "maximize,class:^(winbox.exe)$"
        "maximize,title:^(nvim)$"
        "size 60% 80%,class:^(org.telegram.desktop|vlc)$"
        "size 60% 80%,title:^(Open Files|ranger)$"
        "float,class:^(rofi)$"
        "center,class:^(org.telegram.desktop|Open Files|ranger|vlc)$"
        "fullscreen,class:^(firefox)$$"
        "fullscreen,class:^(discord)$$"
      ];
      #layerrule = [ "blur,gtk-layer-shell" ];
      bezier = [ "myBezier, 0.5, 0.9, 0.1, 1.05" ];
      animation = [
        "windows,          1, 5,   myBezier,"
        "windowsOut,       1, 5,   default, slide"
        "border,           1, 10,  default"
        "borderangle,      1, 8,   default"
        "fade,             1, 7,   default"
        "workspaces,       1, 1.5, default"
        "specialWorkspace, 1, 5,   myBezier, slidevert"
      ];
    };
  };

  imports = [
    ./waybar.nix
    ./xdg.nix
  ];

  programs = {
    rofi = {
      enable = true;
      extraConfig = {
        modi = "run,drun,window,ssh";
        show-icons = true;
        scroll-method = 1;
      };
    };
    hyprlock = {
      enable = true;
      settings = {
        background = {
          path = "screenshot";
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

  home.packages = with pkgs; [
    hyprpaper
    blueman

    # Volume controls
    (pkgs.writeShellScriptBin "volume-decrease" ''
      wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-
      ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga
    '')
    (pkgs.writeShellScriptBin "volume-increase" ''
      wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
      ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga
    '')
  ];

  services = {
    mako = {
      enable = true;
      extraConfig = ''
        default-timeout = timeout
        ignore-timeout = 1
      '';
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
            on-timeout = "${pkgs.brightnessctl} -s set 10";
            on-resume = "${pkgs.brightnessctl} -r";
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
}