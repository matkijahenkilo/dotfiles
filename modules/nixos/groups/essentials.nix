{ pkgs, ... }: {
  imports = [
    ../boot.nix
    ../nix.nix
    ../i18n.nix
    ../ssh.nix
    ../hosts.nix
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

  services.openssh.enable = true;

  # dont fockign forget passwd
  users.users.marisa = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    wget
    killall
    pavucontrol
    ffmpeg
    tree

    zip
    p7zip
    rar
    unrar
  ];
}