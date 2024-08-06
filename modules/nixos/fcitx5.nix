{ pkgs, ... }:
  let
    path = ./../../assets/fcitx5;
  in {
  # pretty jp font
  fonts.packages = with pkgs; [
    source-han-sans
    source-han-mono
    source-han-serif
  ];
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {

      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-lua
      ];

      quickPhraseFiles = {
        words = path + /words.mb;
      };

      waylandFrontend = true;

      settings = {
        inputMethod = {
          "Groups/0" = {
            Name = "Nice";
            # Layout
            "Default Layout" = "br";
            # Default Input Method
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0" = {
            # Name
            Name = "keyboard-br";
            # Layout
            #Layout=
          };
          "Groups/0/Items/1" = {
            # Name
            Name = "mozc";
            # Layout
            #Layout=
          };
          GroupOrder = {
            "0" = "Nice";
          };
        };

        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = true;
            EnumerateSkipFirst = false;
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Super+space";
          };
          "Hotkey/AltTriggerKeys" = {
            "0" = "Shift_L";
          };
          "Hotkey/EnumerateGroupForwardKeys" = {
            "0" = "Super+space";
          };
          "Hotkey/EnumerateGroupBackwardKeys" = {
            "0" = "Shift+Super+space";
          };
          "Hotkey/PrevPage" = {
            "0" = "Up";
          };
          "Hotkey/NextPage" = {
            "0" = "Down";
          };
          "Hotkey/PrevCandidate" = {
            "0" = "Shift+Tab";
          };
          "Hotkey/NextCandidate" = {
            "0" = "Tab";
          };
          "Hotkey/TogglePreedit" = {
            "0" = "Control+Alt+P";
          };
          Behavior = {
            # Active By Default
            ActiveByDefault = true;
            # Reset state on Focus In
            resetStateWhenFocusIn = "No";
            # Share Input State
            ShareInputState = "All";
            # Show preedit in application
            PreeditEnabledByDefault = true;
            # Show Input Method Information when switch input method
            ShowInputMethodInformation = true;
            # Show Input Method Information when changing focus
            showInputMethodInformationWhenFocusIn = false;
            # Show compact input method information
            CompactInputMethodInformation = true;
            # Show first input method information
            ShowFirstInputMethodInformation = true;
            # Default page size
            DefaultPageSize = 5;
            # Override Xkb Option
            OverrideXkbOption = false;
            # Custom Xkb Option
            #CustomXkbOption=
            # Force Enabled Addons
            #EnabledAddons=
            # Force Disabled Addons
            #DisabledAddons=
            # Preload input method to be used by default
            PreloadInputMethod = true;
            # Allow input method in the password field
            AllowInputMethodForPassword = false;
            # Show preedit text when typing password
            ShowPreeditForPassword = false;
            # Interval of saving user data in minutes
            AutoSavePeriod = 30;
          };
        };
      };
    };
  };
  environment.variables = {
    QT_IM_MODULE = "fcitx";
    QT_QPA_PLATFORM="xcb";
  };
}
