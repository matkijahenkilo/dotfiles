{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains.idea-community-bin
    jdk21
    kotlin
  ];
}
