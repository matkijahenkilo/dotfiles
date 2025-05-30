{
  lib,
  ...
}:
{
  imports = [
    ../groups/essentials.nix
    ../gnupg-agent.nix
    ../services/tsih-robo-ktx.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = lib.mkForce false;
    limine.enable = lib.mkForce false;
  };
}
