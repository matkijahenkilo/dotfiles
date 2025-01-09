{ config, pkgs, ... }: {
  imports = [
    ../boot.nix
    ../nix.nix
    ../gnupg-agent.nix
    ../pipewire.nix

    # CLI
    ../ssh.nix

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
  ];
}