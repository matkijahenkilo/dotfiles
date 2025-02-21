{
  stdenv,
  fetchurl,
  lib,

  pkg-config,
  libX11,
  libXext,
  libXrandr,
  libXrender,
  libglvnd,
  meson,
  ninja,
  makeWrapper,
  wrapperDir ? "/run/wrappers/bin",
  addDriverRunpath,
}:
stdenv.mkDerivation (finalAttrs: {
  pname="gpu-screen-recorder-notification";
  version = "1.0.3";

  src = fetchurl {
    url = "https://dec05eba.com/snapshot/gpu-screen-recorder-notification.git.${finalAttrs.version}.tar.gz";
    hash = "sha256-s4LTKP/eFwC6lwAsQKOTBjtaJoZ0yQTUTdfFtMM4saE=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    meson
    pkg-config
    ninja
    libX11
    libXext
    libXrandr
    libXrender
    libglvnd
    makeWrapper
  ];

  postInstall = ''
    mkdir $out/bin/.wrapped
    mv $out/bin/gsr-notify $out/bin/.wrapped/
    makeWrapper "$out/bin/.wrapped/gsr-notify" "$out/bin/gsr-notify" \
      --prefix LD_LIBRARY_PATH : "${
        lib.makeLibraryPath [
          libglvnd
          addDriverRunpath.driverLink
        ]
      }" \
      --prefix PATH : "${wrapperDir}" \
      --suffix PATH : "$out/bin"
  '';

  meta = {
    description = "Notification in the style of ShadowPlay";
    homepage = "https://git.dec05eba.com/gpu-screen-recorder-notification/about/";
    license = lib.licenses.gpl3Only;
    mainProgram = "gpu-screen-recorder-notification";
    maintainers = with lib.maintainers; [ matkijahenkilo ];
    platforms = [ "x86_64-linux" ];
  };
})