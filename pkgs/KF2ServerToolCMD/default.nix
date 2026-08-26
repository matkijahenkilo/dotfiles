# after running `KF2ServerToolCMD -installserver /absolute/path/to/server`
# run `steam-run /absolute/path/to/server/Binaries/Win64/KFGameSteamServer.bin.x86_64`
# once before configuring the server with KF2ServerToolCMD.
#
# my default launch config:
# `steam-run /absolute/path/to/server/Binaries/Win64/KFGameSteamServer.bin.x86_64 'KF-Nuked?Mutator=UnofficialKFPatch.UKFPMutator,LTI.Mut?LinuxCrashHack=1?DisableTraderLocking=1?BroadcastPickups=1?DropAllWepsOnDeath=1?NoEDARs=1' '-AdminName=nanako'`
# fuck EDARs
{
  lib,
  stdenv,
  autoPatchelfHook,
  makeWrapper,
  steamcmd,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "KF2ServerToolCMD";
  version = "1.3.5";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/darkdks/KF2ServerTool/master/code/KF2ServerToolCMD";
    hash = "sha256-nHEHglPdSduNgYUzuZm0wKjaNsrJ7XUF42/hWgM+DPU=";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [ stdenv.cc.cc.lib ];

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/KF2ServerToolCMD
    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/KF2ServerToolCMD \
      --prefix PATH : ${lib.makeBinPath [ steamcmd ]} \
      --run '
        # The generated .ini comes with SteamCmdTool=/usr/games/steamcmd
        #
        # first run will error, but the second run will work!
        #
        if [ -f KFServerToolCMD.ini ] && grep -q "^SteamCmdTool=" KFServerToolCMD.ini; then
          sed -i "s|^SteamCmdTool=.*|SteamCmdTool=${steamcmd}/bin/steamcmd|" KFServerToolCMD.ini
        fi
      '
  '';

  meta = with lib; {
    homepage = "https://github.com/darkdks/KF2ServerTool";
    platforms = [ "x86_64-linux" ];
    mainProgram = "KF2ServerToolCMD";
  };
}
