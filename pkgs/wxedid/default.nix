# ANOS DE DESENVOLVIMENTO TECNOLÓGICO
# E AINDA NÃO DESCOBRIRAM COMO MUDAR CONFIGURAÇÕES
# DA AMDGPU DE FORMA TÃO TRIVIAL QUANTO NO WINDOWS
# VAI TOMA NO CUUUUUUUUUUUUUUUUUU
# https://www.wezm.net/v2/posts/2020/linux-amdgpu-pixel-format/
{
  autoreconfHook,
  lib,
  stdenv,
  fetchurl,
  wxGTK32,
}:
let
  pname = "wxedid";
  version = "0.0.32";
in
stdenv.mkDerivation {
  pname = pname;
  version = version;

  src = fetchurl {
    url = "https://downloads.sourceforge.net/${pname}/${pname}-${version}.tar.gz";
    hash = "sha256-XYbRNuQ+ha05gJgs7P+HzxdRksFRJHxLiWDfnF5GHMI=";
  };

  patchPhase = ''
    runHook prePatch

    # wrong shebang written by the devs
    # being #!/bin/bash
    # instead of #!/usr/bin/env bash
    # simply because there's no guarantee to exist Bash in NixOS1!!!1!
    patchShebangs ./src/rcode/rcd_autogen

    runHook postPatch
  '';

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ wxGTK32 ];
}