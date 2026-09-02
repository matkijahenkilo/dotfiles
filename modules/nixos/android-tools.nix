{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
  ];

  users.users.marisa.extraGroups = [
    "adbusers"
  ];
}
