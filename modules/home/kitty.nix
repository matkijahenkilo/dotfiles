{ pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
  };

  home.sessionVariables = {
    TERMINAL = lib.mkDefault "kitty";
  };
}
