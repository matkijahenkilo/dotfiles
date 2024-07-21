{ pkgs, ... }: {
  imports = [
    ../boot.nix
    ../nix.nix
    ../gnupg-agent.nix

    # CLI
    ../ssh.nix
    ../nh.nix

    # GUI
    ../fcitx5.nix
    ../pipewire.nix
    ../steam.nix
  ];

  programs = {
    neovim.enable = true;
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    pavucontrol
  ];
}
