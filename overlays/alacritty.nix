final: prev: {
  alacritty = (
    final.writeShellScriptBin "alacritty" ''
      ${final.nixgl.nixGLIntel}/bin/nixGLIntel ${prev.alacritty}/bin/alacritty "$@"
    ''
  );
}
