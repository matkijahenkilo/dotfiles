{ pkgs, ... }: {
  imports = [
    ./boot.nix
    ./nix.nix
    ./gnupg-agent.nix
    ./ssh.nix
    ./nh.nix

    ./fcitx5.nix
    ./pipewire.nix
    
    ./steam.nix
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
