{ config, pkgs, ... }: {
  imports = [
    ../groups/essentials.nix
    ../groups/desktop.nix
    ../groups/games.nix

    ../sessions/plasma.nix

    ../amdgpu-fullrgb-patcher.nix
    ../zerotierone.nix
    ../gnupg-agent.nix
    ../docker.nix

    ../kf2server.nix
    ../llm.nix
    # ../virtualization.nix
  ];
}