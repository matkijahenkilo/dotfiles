{ pkgs, ... }:
{
  # cool plugins to use with vencord:
  #
  # youtubeAdblock
  # fakeNitro
  # noF1
  # alwaysAnimate
  # favoriteGifSearch
  # whoReacted
  # callTimer
  # petpet

  home.packages = [
    (pkgs.callPackage (../../pkgs/krisp-patcher) { })
    # (pkgs.discord.override { withVencord = true; nss = pkgs.nss_latest; })
    pkgs.discord
  ];
}
