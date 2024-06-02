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
    mkHome = libs.mkHome;
  in {
    nixosConfigurations = {
      gamma = mkHost ./hosts/gamma/configuration.nix;
    };
    homeConfigurations = {
      "marisa@gamma" = mkHome "x86_64-linux" "marisa";
    };
  };
}
