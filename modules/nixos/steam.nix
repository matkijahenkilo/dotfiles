{ pkgs, ... }:
let
  # Custom Proton made for using VRChat's
  # selfie expression with webcam
  proton-ge-qcap-dshow-fixes = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "proton-ge-qcap-dshow-fixes-bin";
    version = "ge-proton10-34-qcap-dshow-fixes";

    src = pkgs.fetchzip {
      url = "https://github.com/LilFishyChan/proton-ge-custom/releases/download/ge-proton10-34-qcap-dshow-fixes/ge-proton10-34-qcap-dshow-fixes.tar.gz";
      hash = "sha256-W73txUHZOiLAAC4XX7V276LIFtoAAdGBsg3IXinh1VE=";
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
        --replace-fail "${finalAttrs.version}" "GE-Proton-10-34-qcap-dshow-fixes"
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
        MANGOHUD = true;
      };
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      proton-ge-qcap-dshow-fixes
    ];
  };
}
