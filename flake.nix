{
  description = "My personal NixOS and dotfiles configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-amdvlk.url = "github:nixos/nixpkgs/9b8a2204c4ff7c591fd81e8eb624296c97456128";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nixgl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    amdgpu-fullrgb-patch = {
      url = "git+https://gist.github.com/rafaelrc7/0270037dbe86205365ec8b7a4f339f82";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-amdvlk, nixgl, nixos-hardware, ... }:
  let
    libs = import ./libs/default.nix { inherit inputs; };
    mkHost = libs.mkHost;
    mkHome = libs.mkHome;
    nixosPkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
      overlays = [
        (
          final: prev: {
            flameshot = prev.flameshot.override { enableWlrSupport = true; };
          }
        )
        (
          final: prev: {
            amdvlk-latest = (import nixpkgs-amdvlk {
              system = final.system;
            }).amdvlk;
          }
        )
      ];
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
      quirera = mkHost nixosPkgs ./hosts/quirera/configuration.nix [  ];
    };
    homeConfigurations = {
      gamma   = mkHome nixosPkgs "marisa" "gamma.nix";
      quirera = mkHome nixosPkgs "marisa" "quirera.nix";
      tau     = mkHome homePkgs "marisa" "tau.nix";
    };
  };
}
