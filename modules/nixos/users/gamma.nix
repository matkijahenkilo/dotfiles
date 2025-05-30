{ config, pkgs, ... }:
{
  imports = [
    ../groups/essentials.nix
    ../groups/desktop.nix
    ../groups/games.nix

    ../sessions/plasma.nix

    ../amdgpu-fullrgb-patcher.nix
    ../zerotierone.nix
    ../gnupg-agent.nix
    ../docker.nix

    ../services/kf2-server.nix
    ../services/minecraft-server.nix
    ../llm.nix
    ../virtualization.nix
  ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];
}
