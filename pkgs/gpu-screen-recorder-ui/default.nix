{
  stdenv,
  lib,
  fetchurl,
  meson,
  ninja,
  pkg-config,
  libX11,
  libXrandr,
  libXrender,
  libXcomposite,
  libXfixes,
  libXi,
  libXcursor,
  libglvnd,
  linuxHeaders,
  libpulseaudio,
  gpu-screen-recorder,
  gpu-screen-recorder-notification,
  makeWrapper,
  wrapperDir ? "/run/wrappers/bin",
  addDriverRunpath,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "gpu-screen-recorder-ui";
  version = "1.1.7";

  src = fetchurl {
    url = "https://dec05eba.com/snapshot/gpu-screen-recorder-ui.git.${finalAttrs.version}.tar.gz";
    hash = "sha256-Py0jID3WC657ojPxpkqW8OJqX2pPUOkDez1RsdaLy60=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    meson
    pkg-config
    ninja
    makeWrapper
    libglvnd
    libX11
    libXrandr
    libXrender
    libXcomposite
    libXfixes
    libXi
    libXcursor
    linuxHeaders
    libpulseaudio
  ];

  buildInputs = [
    gpu-screen-recorder
    gpu-screen-recorder-notification
  ];

  mesonFlags = [
    # Handle by the module
    (lib.mesonBool "capabilities" false)
  ];

  postInstall = ''
    mkdir $out/bin/.wrapped
    mv $out/bin/gsr-ui $out/bin/.wrapped/
    makeWrapper "$out/bin/.wrapped/gsr-ui" "$out/bin/gsr-ui" \
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
    description = "A fullscreen overlay UI for GPU Screen Recorder in the style of ShadowPlay";
    homepage = "https://git.dec05eba.com/gpu-screen-recorder-ui/about/";
    license = lib.licenses.gpl3Only;
    mainProgram = "gpu-screen-recorder-ui";
    maintainers = with lib.maintainers; [ matkijahenkilo ];
    platforms = [ "x86_64-linux" ];
  };
})