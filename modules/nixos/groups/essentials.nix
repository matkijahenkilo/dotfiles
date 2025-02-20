{ pkgs, ... }: {
  imports = [
    ../boot.nix
    ../nix.nix
    ../ssh.nix
  ];

  programs = {
    neovim.enable = true;
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    killall
    pavucontrol
    ffmpeg
  ];
}