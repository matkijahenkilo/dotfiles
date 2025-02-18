{ pkgs, libs, ... }: {
  imports = [
    ../groups/essentials.nix

    ../groups/cli.nix
    ../fastfetch.nix
    ../syncthing.nix
    ../gschemas.nix

    ../groups/gui.nix
    ../sessions/plasma
    ../groups/games.nix
    ../fcitx5.nix
    ../flameshot.nix
  ];

  home.packages =
  let
    path = ../../../pkgs;
  in
  let
    wxedid = pkgs.callPackage (path + /wxedid) { };
  in [
    wxedid
  ];
}