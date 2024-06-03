{ pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    package = pkgs.writeShellScriptBin "kitty" ''
      #!/bin/sh

      ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.kitty}/bin/kitty "$@"
    '';
  };

  home.sessionVariables = {
    TERMINAL = lib.mkDefault "kitty";
  };
}
