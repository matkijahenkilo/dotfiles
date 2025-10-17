# usage:
#
# find discord_krisp.node:
# $ find ~/ -name 'discord_krisp.node'
# copy path, then use it as argument for the script:
# $ krisp-patcher ./.config/discord/0.0.111/modules/discord_krisp/discord_krisp.node
{
  stdenv,
  python3,
}:
stdenv.mkDerivation {
  name = "krisp-patcher";
  installPhase = "install -Dm755 ${./krisp-patcher.py} $out/bin/krisp-patcher";
  dontUnpack = true;
  propagatedBuildInputs = [
    (python3.withPackages (
      pythonPackages: with pythonPackages; [
        capstone
        pyelftools
      ]
    ))
  ];
}
