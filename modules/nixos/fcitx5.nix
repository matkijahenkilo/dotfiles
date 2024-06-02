{ pkgs, ... }:
  let
    path = ./../../assets/fcitx5;
  in {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {

      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-lua
      ];

      quickPhraseFiles = {
        words = path + /words.mb;
      };

      settings = {

        inputMethod = {
          "Groups/0" = {
            Name = "Nice";
            "Default Layout" = "br";
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-br";
          };
          "Groups/0/Items/1" = {
            Name = "mozc";
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
          Behavior = {
            DefaultPageSize = 5;
          };
        };
      };
    };
  };
  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
  };
}
