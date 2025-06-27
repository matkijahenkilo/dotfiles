{ pkgs, ... }:
{
  imports = [
    ../boot.nix
    ../nix.nix
    ../git.nix
    ../i18n.nix
    ../ssh.nix
    ../hosts.nix
    ../direnv.nix
  ];

  programs = {
    git.enable = true;
    zsh.enable = true;
  };

  environment = {
    shells = [ pkgs.zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  time.timeZone = "Brazil/East";

  # dont fockign forget passwd
  users.users.marisa = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "sudo"
    ];
    shell = pkgs.zsh;
  };
  users.users.nanako = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "sudo"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    wget
    killall
    micro
  ];
}
