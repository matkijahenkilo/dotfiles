{ pkgs, lib, ... }: {
  programs.kitty = { # requires nixGL which I'm too dumb to make it work
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
