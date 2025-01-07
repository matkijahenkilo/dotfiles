{
  description = "My personal NixOS and dotfiles configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix";

    nixgl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixgl, nixos-hardware, ... }:
  let
    libs = import ./libs/default.nix { inherit inputs; };
    mkHost = libs.mkHost;
    mkHome = libs.mkHome;
    nixosPkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
    };
    homePkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
      overlays = [
        nixgl.overlay
        (
          final: prev: {
            kitty = (homePkgs.writeShellScriptBin "kitty" ''
              ${final.nixgl.nixGLIntel}/bin/nixGLIntel ${prev.kitty}/bin/kitty "$@"
            '');
          }
        )
        (
          final: prev: {
            vesktop = (homePkgs.writeShellScriptBin "vesktop" ''
              ${final.nixgl.nixGLIntel}/bin/nixGLIntel ${prev.vesktop}/bin/vesktop "$@"
            '');
          }
        )
      ];
    };
  in {
    nixosConfigurations = {
      gamma   = mkHost nixosPkgs ./hosts/gamma/configuration.nix [  ];
      quirera = mkHost nixosPkgs ./hosts/quirera/configuration.nix [ nixos-hardware.nixosModules.common-cpu-amd ];
    };
    homeConfigurations = {
      gamma   = mkHome homePkgs "marisa" "gamma.nix";
      quirera = mkHome nixosPkgs "marisa" "quirera.nix";
      tau     = mkHome homePkgs "marisa" "tau.nix";
    };
  };
}
