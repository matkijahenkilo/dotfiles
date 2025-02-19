{ config, pkgs, ... }: {
  imports = [
    ../boot.nix
    ../nix.nix
    ../gnupg-agent.nix
    ../fonts.nix

    # CLI
    ../ssh.nix

    # GUI
    ../fcitx5.nix
    ../pipewire.nix
    ../steam.nix
  ];

  programs = {
    neovim.enable = true;
    git.enable = true;
    nh = {
      enable = true;
      flake = "${config.users.users.marisa.home}/.dotfiles";
    };
  };

  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    pavucontrol
  ];
}
