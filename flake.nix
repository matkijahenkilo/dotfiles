{
  description = "My personal NixOS and dotfiles configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = inputs@{ ... }:
  let
    libs = import ./libs/default.nix { inherit inputs; };
    mkHost = libs.mkHost;
    pkgsFor = libs.pkgsFor;
  in {
    nixosConfigurations = {
      gamma = mkHost ./hosts/gamma/configuration.nix;
    };
    homeConfigurations = {
      marisa = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsFor "x86_64-linux";
        modules = [
          ./modules/home
          {
            programs.home-manager.enable = true;
            home = {
              username = "marisa";
              homeDirectory = "/home/marisa";
              stateVersion = "23.11";
            };
          }
        ];
      };
    };
  };
}
