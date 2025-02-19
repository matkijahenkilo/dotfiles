{ config, pkgs, ... }: {
  imports = [
    ../boot.nix
    ../nix.nix
    ../gnupg-agent.nix
    ../pipewire.nix
    ../zerotierone.nix
    ../amdgpu-fullrgb-patcher.nix
    ../fonts.nix

    # CLI
    ../ssh.nix
    ../gpu-screen-recorder.nix

    # GUI
    ../fcitx5.nix
    ../steam.nix
    ../sessions/plasma.nix
  ];

  programs = {
    neovim.enable = true;
    git.enable = true;
    nh = {
      enable = true;
      flake = "${config.users.users.marisa.home}/.dotfiles";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    pavucontrol
    ffmpeg
  ];
}