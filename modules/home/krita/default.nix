{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ krita ];

  # Scripts location (~/.local/share/krita)
  xdg.dataFile =
    let
      shortcut-composer = (pkgs.callPackage (../../../pkgs/shortcut-composer) { });
      deevad-brush-bundle = pkgs.fetchzip {
        url = "https://www.peppercarrot.com/extras/resources/deevad-bundle_25.01.zip";
        hash = "sha256-B6ck8e9OPVaamid9VuM+ZY609Ew2xlmDpr6AeaLqpgg=";
      };
    in
    {
      "krita/Deevad_25.01.bundle".source = "${deevad-brush-bundle}/Deevad_25.01.bundle";
      "krita/pykrita" = {
        source = shortcut-composer;
        # this avoids symlinking the entire folder,
        # can still load new plugins imperatively
        # and allow krita to generate cache for them
        recursive = true;
      };
    };

  # Generate writable rc files for Krita
  # useful for a brand new computer so I don't have to
  # configure everything from zero
  home.activation.initKritaConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    TARGET_DIR="$HOME/.config"

    init_config() {
      local filename="$1"
      local source_path="$2"

      if [ ! -f "$TARGET_DIR/$filename" ]; then
        cat "$source_path" > "$TARGET_DIR/$filename"
      fi
    }

    init_config "kritadisplayrc" "${./kritadisplayrc}"
    init_config "kritarc" "${./kritarc}"
    init_config "kritashortcutsrc" "${./kritashortcutsrc}"
  '';
}
