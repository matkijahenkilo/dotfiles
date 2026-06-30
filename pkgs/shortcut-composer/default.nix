{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation (finalAttrs: {
  pname = "Shortcut-Composer";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "wojtryb";
    repo = "Shortcut-Composer";
    tag = "v${finalAttrs.version}";
    hash = "sha256-G/Aos9tE8ssg1sUdZEjWvdeV2joS63Sf25RdbizVKjE=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    mv shortcut_composer/ shortcut_composer.desktop $out/

    runHook postInstall
  '';
})
