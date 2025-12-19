final: prev:
let
  discord = (prev.discord.override {
    withVencord = true;
    nss = prev.nss_latest;
  });
in
{
  discord = final.symlinkJoin {
    pname = discord.pname;
    version = discord.version;
    paths = [ discord ];
    buildInputs = [ final.makeWrapper ];
    postBuild = ''
      wrapProgram $out/opt/Discord/Discord \
        --set NIXOS_OZONE_WL "1" \
        --add-flags "--enable-blink-features=MiddleClickAutoscroll"
    '';
  };
}
