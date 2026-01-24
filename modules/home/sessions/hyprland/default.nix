{ pkgs, ... }:
{
  imports = [
    ./wayland.nix
    ./waybar.nix
    ../xdg.nix
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      env = [
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
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
        # drop_shadow = "yes";
        # shadow_range = 4;
        # shadow_render_power = 3;
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
        "$mainMod, Return, exec, alacritty"
        "$mainMod SHIFT, C, killactive, "
        # "$mainMod SHIFT, Q, exec, wlogout -p layer-shell"
        "$mainMod SHIFT, Q, exit, "
        "$mainMod, F, fullscreen, 0"
        "$mainMod, G, togglegroup, "
        "CTRL SHIFT, 3, exec, script-screenshot"
        "CTRL SHIFT, 2, exec, script-screenshot-selection"
        "$mainMod, tab, togglespecialworkspace"
        "$mainMod SHIFT, tab, movetoworkspace, special"
        "$mainMod SHIFT, X, movetoworkspace, 1"
        "$mainMod, backslash, exec, alacritty -e ranger"
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating, "
        "$mainMod, D, exec, wofi --show run"
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
        ", XF86AudioRaiseVolume, exec, script-volume-increase"
        ", XF86AudioLowerVolume, exec, script-volume-decrease"
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
}
