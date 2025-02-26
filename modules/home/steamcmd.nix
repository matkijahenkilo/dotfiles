{ pkgs, ... }: {
  # steamcmd... is steamcmd
  # steam-run is to actually run steamcmd's stuff
  # example:
  # steam-run ./Binaries/Win64/KFGameSteamServer.bin.x86_64 'KF-BurningParis?Mutator=UnofficialKFPatch.UKFPMutator?NoEDARs=1'
  # where ./ is the dir that steamcmd ran force_install_dir
  home.packages = with pkgs; [
    steamcmd
    steam-run
  ];
}