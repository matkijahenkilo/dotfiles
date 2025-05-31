{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zip
    p7zip
    unrar
  ];
}