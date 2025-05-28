{ pkgs, libs, ... }:
{
  imports = [
    ../groups/essentials.nix

    ../groups/cli.nix
    ../groups/hoardingcli.nix
    ../fastfetch.nix
    ../syncthing.nix
    ../gschemas.nix

    ../groups/gui.nix
    ../sessions/plasma
    ../groups/games.nix
    ../fcitx5.nix
    ../idea.nix
  ];

  home.packages =
    (
      let
        path = ../../../pkgs;
      in
      let
        wxedid = pkgs.callPackage (path + /wxedid) { };
      in
      [
        wxedid
      ]
    )
    ++ (with pkgs; [
      kdePackages.kdenlive
      dbeaver-bin
    ]);
}
