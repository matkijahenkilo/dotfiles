{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qtcreator
    qt6.qtbase
    cmake
    gnumake
    gcc
    gdb
  ];
}
