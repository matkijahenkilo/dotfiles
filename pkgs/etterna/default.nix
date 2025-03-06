{ lib, stdenv, fetchFromGitHub, fetchgit, writeShellScript, makeDesktopItem
, copyDesktopItems,
# deps
clang, cmake, python2, pkg-config, openssl, libGLU, xorg, alsa-lib, libjack2
, libpulseaudio, libogg,

# cfgs
enableCrashpad ? false, }:
stdenv.mkDerivation (finalAttrs: {
  pname = "etterna";
  version = "0.74.3";

  src = fetchFromGitHub {
    owner = "etternagame";
    repo = "etterna";
    tag = "v${finalAttrs.version}";
    hash = "sha256-zzCk6axISswfTAk7rRha5HFzIHQ0AjpAZyAWzH+Cn1s=";
  };

  patches = [ ./fix-download-manager.patch ];

  nativeBuildInputs = [
    clang
    cmake
    pkg-config

    openssl

    alsa-lib
    libjack2
    libpulseaudio

    libGLU
    libogg

    xorg.libXinerama
    xorg.libXrandr
    xorg.libX11
    xorg.libXext # Needed for DPMS
    xorg.libXvMC

    copyDesktopItems
  ] ++ lib.optionals enableCrashpad [ python2 ];

  desktopItems = [
    (makeDesktopItem {
      name = "etterna";
      desktopName = "Etterna";
      genericName = "Rhythm and dance game";
      icon = "etterna";
      tryExec = "etterna";
      exec = "etterna";
      categories = [ "Application" "Game" "ArcadeGame" ];
      comment = "A cross-platform rhythm video game.";
      terminal = false;
    })
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/{bin,share/etterna}
    mkdir -p $out/share/applications
    # copy select necessary game files into virtual fs
    for dir in \
      Announcers Assets BGAnimations \
      BackgroundEffects BackgroundTransitions \
      Data GameTools NoteSkins Scripts \
      Themes
    do
      cp -r "/build/source/$dir" "$out/share/etterna/$dir"
    done
    # copy binary
    cp /build/source/Etterna $out/bin/etterna-unwrapped

    # Install the Icon
    install -Dm644 /build/source/Docs/images/etterna-logo-light.svg "$out/share/icons/hicolor/scalable/apps/etterna.svg"

    # wacky insertion of wrapper directly into phase, so that $out is set
    cat > $out/bin/etterna << EOF
    #!${stdenv.shell}
    export ETTERNA_ROOT_DIR="\$HOME/.local/share/etterna"
    export ETTERNA_ADDITIONAL_ROOT_DIRS="$out/share/etterna"
    echo "HOME: \$HOME"
    echo "PWD: \$(pwd)"
    echo "ETTERNA_ADDITIONAL_ROOT_DIRS: \$ETTERNA_ADDITIONAL_ROOT_DIRS"
    exec $out/bin/etterna-unwrapped "\$@"
    EOF
    chmod +x $out/bin/etterna
    runHook postInstall
  '';

  cmakeFlags = lib.optionals (!enableCrashpad) [ "-D WITH_CRASHPAD=OFF" ];

  meta = with lib; {
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ alikindsys ];
    mainProgram = "etterna";
  };
})
