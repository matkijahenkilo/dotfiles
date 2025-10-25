{ pkgs, ... }:
{
  imports = [
    ./java.nix
  ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extest.enable = true;
    protontricks.enable = true;
    package = pkgs.steam.override {
      extraPkgs =
        p: with p; [
          glxinfo
          jdk
          mangohud
        ];
      extraLibraries =
        p: with p; [
          gperftools
          harfbuzz
          libthai
          pango
        ];
      extraEnv = {
        SDL_VIDEODRIVER = "";
        QT_QPA_PLATFORM = "";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "";
        XDG_SESSION_TYPE = "";
        MANGOHUD = true;
      };
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
