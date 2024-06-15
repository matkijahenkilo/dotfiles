{ pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    package = pkgs.writeShellScriptBin "kitty" ''
      ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.kitty}/bin/kitty "$@"
    '';
  };

  home.sessionVariables = {
    TERMINAL = lib.mkDefault "kitty";
  };
}
