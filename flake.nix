{
  description = "My personal NixOS and dotfiles configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nixgl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixgl, ... }:
  let
    libs = import ./libs/default.nix { inherit inputs; };
    mkHost = libs.mkHost;
    mkHome = libs.mkHome;
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [
        nixgl.overlay
      ];
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      gamma = mkHost ./hosts/gamma/configuration.nix;
    };
    homeConfigurations = {
      marisa = mkHome pkgs "marisa";
    };
  };
}
