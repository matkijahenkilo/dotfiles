# Tested on Davinci 20.0.1. It works for loading videos and exporting in H264/5 & AV1
# This module doesn't seems to crack Davinci 20.2.1 and crashes 20.3.2
# Even if following this guide https://www.reddit.com/r/LinuxCrackSupport/comments/1nfqhld/davinci_resolve_studio_202_fix_linux_crack_guide/
# nixpkgs rev used for this tests: 59e69648d345d6e8fef86158c555730fa12af9de

{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pkgs-davinci = inputs.nixpkgs-davinci.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
let
  ffmpeg-encoder-plugin = pkgs.stdenv.mkDerivation (finalAttrs: {
    pname = "ffmpeg-encoder-plugin";
    version = "1.2.1";

    src = pkgs.fetchFromGitHub {
      owner = "EdvinNilsson";
      repo = "ffmpeg_encoder_plugin";
      tag = "v${finalAttrs.version}";
      hash = "sha256-F4Q8YCXD5UldTwLbWK4nHacNPQ/B+4yLL96sq7xZurM=";
    };

    nativeBuildInputs = with pkgs; [
      cmake
      ffmpeg-full
    ];

    buildInputs = with pkgs; [ ffmpeg ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp ffmpeg_encoder_plugin.dvcp $out/

      runHook postInstall
    '';
  });

  davinci-resolve-studio-cracked =
    let
      studioVariant = true; # lazy way to decrease code maintenance
      davinci = pkgs-davinci.davinci-resolve-studio.davinci.overrideAttrs (old: {
        # script based on https://www.reddit.com/r/LinuxCrackSupport/comments/1nfqhld/davinci_resolve_studio_202_fix_linux_crack_guide/
        #
        # Additionally, it will install ffmpeg_encoder_plugin to enable H264/5 & AV1 exports:
        # https://github.com/EdvinNilsson/ffmpeg_encoder_plugin
        #
        # Note: $out IS /opt/resolve
        postInstall = ''
          ${old.postInstall or ""}
          ${lib.getExe pkgs.perl} -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' $out/bin/resolve
          ${lib.getExe pkgs.perl} -pi -e 's/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\x74\x11\x48\x8B\x45\xC8\x8B/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\xEB\x11\x48\x8B\x45\xC8\x8B/' $out/bin/resolve
          ${lib.getExe pkgs.perl} -pi -e 's/\x74\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/\xEB\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/' $out/bin/resolve
          ${lib.getExe pkgs.perl} -pi -e 's/\x41\xb6\x01\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/\x41\xb6\x00\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/' $out/bin/resolve
          touch $out/.license/blackmagic.lic
          echo -e "LICENSE blackmagic davinciresolvestudio 999999 permanent uncounted\n  hostid=ANY issuer=CGP customer=CGP issued=28-dec-2023\n  akey=0000-0000-0000-0000 _ck=00 sig=\"00\"" > $out/.license/blackmagic.lic

          mkdir -p $out/IOPlugins/ffmpeg_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64/
          cp ${ffmpeg-encoder-plugin}/ffmpeg_encoder_plugin.dvcp $out/IOPlugins/ffmpeg_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64/
        '';
      });
    in

    # the following was copied from davinci's derivation from nixpkgs.
    # if davinci updates, this should be updated too
    pkgs.buildFHSEnv {
      inherit (davinci) pname version;

      targetPkgs =
        pkgs: with pkgs; [
          alsa-lib
          aprutil
          bzip2
          davinci
          dbus
          expat
          fontconfig
          freetype
          glib
          libGL
          libGLU
          libarchive
          libcap
          librsvg
          libtool
          libuuid
          libxcrypt # provides libcrypt.so.1
          libxkbcommon
          nspr
          ocl-icd
          opencl-headers
          python3
          python3.pkgs.numpy
          udev
          xdg-utils # xdg-open needed to open URLs
          libice
          libsm
          libx11
          libxcomposite
          libxcursor
          libxdamage
          libxext
          libxfixes
          libxi
          libxinerama
          libxrandr
          libxrender
          libxt
          libxtst
          libxxf86vm
          libxcb
          libxcb-util
          libxcb-image
          libxcb-keysyms
          libxcb-render-util
          libxcb-wm
          xkeyboard-config
          zlib
        ];

      extraPreBwrapCmds = lib.optionalString studioVariant ''
        mkdir -p ~/.local/share/DaVinciResolve/license || exit 1
        mkdir -p ~/.local/share/DaVinciResolve/Extras || exit 1
      '';

      extraBwrapArgs = lib.optionals studioVariant [
        ''--bind "$HOME"/.local/share/DaVinciResolve/license ${davinci}/.license''
        ''--bind "$HOME"/.local/share/DaVinciResolve/Extras ${davinci}/Extras''
      ];

      runScript = "${pkgs.bash}/bin/bash ${pkgs.writeText "davinci-wrapper" ''
        export QT_XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
        export QT_PLUGIN_PATH="${davinci}/libs/plugins:$QT_PLUGIN_PATH"
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib32:${davinci}/libs
        ${davinci}/bin/resolve
      ''}";

      extraInstallCommands = ''
        mkdir -p $out/share/applications $out/share/icons/hicolor/128x128/apps
        ln -s ${davinci}/share/applications/*.desktop $out/share/applications/
        ln -s ${davinci}/graphics/DV_Resolve.png $out/share/icons/hicolor/128x128/apps/davinci-resolve${lib.optionalString studioVariant "-studio"}.png
      '';

      passthru = {
        inherit davinci;
      };

      meta = {
        description = "Professional video editing, color, effects and audio post-processing";
        homepage = "https://www.blackmagicdesign.com/products/davinciresolve";
        license = lib.licenses.unfree;
        maintainers = with lib.maintainers; [
          amarshall
          XBagon
          toXel
        ];
        platforms = [ "x86_64-linux" ];
        sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
        mainProgram = "davinci-resolve${lib.optionalString studioVariant "-studio"}";
      };
    };
in
{
  environment.systemPackages = [ davinci-resolve-studio-cracked ];

  # following configuration was taken from
  # https://wiki.nixos.org/wiki/DaVinci_Resolve#AMD
  #
  # Tested and working with AMD cards.
  # I don't know any configurations for Nvidia cards!
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };
  hardware = {
    # this option sets hardware.graphics.enable to true
    # and installs rocmPackages.clr/.icd
    amdgpu.opencl.enable = true;
    graphics.extraPackages = with pkgs; [
      # Enables Rusticl (OpenCL) support
      # Without this, videos won't load in davinci
      mesa.opencl
    ];
  };
}
