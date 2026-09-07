{ pkgs, ... }:
let
  readable-name = "Proton-RTSP-11.0";
  # Custom Proton made for using VRChat's
  # selfie expression with webcam
  proton-rtsp = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "proton-rtsp-11.0-20260609-1";
    version = "proton-rtsp-11.0-20260609-1";

    src = pkgs.fetchzip {
      url = "https://github.com/SpookySkeletons/proton-rtsp/releases/download/proton-rtsp-11.0-20260609-1/proton-rtsp-11.0-20260609-1.tar.gz";
      hash = "sha256-/YrUjR/Ynb0clNpXSaSlfpnqJ76ZfTYP9LR/WHHCMgk=";
    };

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    outputs = [
      "out"
      "steamcompattool"
    ];

    installPhase = ''
      runHook preInstall

      # Make it impossible to add to an environment. You should use the appropriate NixOS option.
      # Also leave some breadcrumbs in the file.
      echo "${finalAttrs.pname} should not be installed into environments. Please use programs.steam.extraCompatPackages instead." > $out

      mkdir $steamcompattool
      ln -s $src/* $steamcompattool
      rm $steamcompattool/compatibilitytool.vdf
      cp $src/compatibilitytool.vdf $steamcompattool

      runHook postInstall
    '';

    preFixup = ''
      substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
        --replace-fail "${finalAttrs.version}" "${readable-name}"
    '';
  });
in
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
          mesa-demos
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
        MANGOHUD = false;
      };
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      proton-rtsp
    ];
  };
}
