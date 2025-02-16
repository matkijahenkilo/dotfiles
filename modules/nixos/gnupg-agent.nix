{ pkgs, ... }: {
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
    enableSSHSupport = true;
    settings = {
      default-cache-ttl = 86400;
    };
  };
}