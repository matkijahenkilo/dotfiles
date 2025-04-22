{
  description = "My personal NixOS and dotfiles configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    # stylix.url = "github:danth/stylix/b00c9f46ae6c27074d24d2db390f0ac5ebcc329f";

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
      overlays = [
        (
          final: prev: {
            flameshot = prev.flameshot.override { enableWlrSupport = true; };
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
      ];
    };
  in {
    nixosConfigurations = {
      default = mkHost nixosPkgs ./hosts/default/configuration.nix [  ];
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
