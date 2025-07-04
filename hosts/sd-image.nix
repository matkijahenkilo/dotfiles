{ lib, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
  ];
  # bzip2 compression takes loads of time with emulation, skip it.
  sdImage.compressImage = false;
  # OpenSSH is forced to have an empty on the installer system[1], this won't allow it
  # to be started. Override it with the normal value.
  # [1] https://github.com/NixOS/nixpkgs/blob/9e5aa25/nixos/modules/profiles/installation-device.nix#L76
  systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];
  services.sshd.enable = true;

  programs.zsh.enable = true;

  users.users = {
    marisa = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "sudo"
      ];
      initialHashedPassword = lib.mkForce "$y$j9T$MVkg3o7HLLw3V1uj4U4wb.$ksxHoeG.ctvhMWyHxxAuQcbJZn8s8OCQpDrzGjA6Tv/";
      shell = pkgs.zsh;
    };
    root = {
      initialHashedPassword = lib.mkForce "$y$j9T$Xoxvz1iUEnEvBLUw9uvdo0$62PU/VVjtyC0Bltb3k2cWzvcF7CWSM.MdsXpCkxN.01";
    };
  };
}
