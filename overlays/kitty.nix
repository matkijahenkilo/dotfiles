final: prev: {
  kitty = (
    final.writeShellScriptBin "kitty" ''
      ${final.nixgl.nixGLIntel}/bin/nixGLIntel ${prev.kitty}/bin/kitty "$@"
    ''
  );
}
