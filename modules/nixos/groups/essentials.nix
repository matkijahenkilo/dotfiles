{ lib, pkgs, ... }:
{
  imports = [
    ../boot.nix
    ../nix.nix
    ../git.nix
    ../i18n.nix
    ../ssh.nix
    ../hosts.nix
    ../direnv.nix
  ];

  programs = {
    git.enable = true;
    zsh.enable = true;
  };

  environment = {
    shells = [ pkgs.zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  time.timeZone = "Brazil/East";

  users.users = {
    root = {
      initialHashedPassword = lib.mkForce "$y$j9T$9jdDe/zfTWRi3sPvuupaX.$W/ALIOufPsH4IROVEjysb7FX126JLoiIINVT3oun9j2";
    };
    marisa = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "sudo"
      ];
      shell = pkgs.zsh;
      initialHashedPassword = lib.mkForce "$y$j9T$IV4LoOgL0BxN68.3I53QG/$dfqOGfWwAzredBrXfyJ.O9yQ2XMlBrYzUPlRFQiDn4A";
    };
    nanako = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "sudo"
      ];
      shell = pkgs.zsh;
      initialHashedPassword = lib.mkForce "$y$j9T$furlO9PD2uaSqLQPmFhe2.$7J4/hdgt9ZQEgeYNB15Tm.zOs8As5FQrjYgjA.qm8AC";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    killall
    micro
  ];
}
