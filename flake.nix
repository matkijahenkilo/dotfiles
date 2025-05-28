{
  description = "My personal NixOS and dotfiles configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    switch-emulators.url = "github:liberodark/my-flakes";

    nixgl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    amdgpu-fullrgb-patch = {
      url = "git+https://gist.github.com/rafaelrc7/0270037dbe86205365ec8b7a4f339f82?ref=refs/tags/v6.14";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      systems,
      treefmt-nix,
      nixgl,
      nixos-hardware,
      ...
    }:
    let
      libs = import ./libs/default.nix { inherit inputs; };
      mkHost = libs.mkHost;
      mkHome = libs.mkHome;

      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

      nixosPkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays = [
          (final: prev: {
            flameshot = prev.flameshot.override { enableWlrSupport = true; };
          })
        ];
      };
      homePkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays = [
          nixgl.overlay
          (final: prev: {
            kitty = (
              homePkgs.writeShellScriptBin "kitty" ''
                ${final.nixgl.nixGLIntel}/bin/nixGLIntel ${prev.kitty}/bin/kitty "$@"
              ''
            );
          })
        ];
      };
      piPkgs = import nixpkgs {
        system = "aarch64-linux";
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        gamma = mkHost nixosPkgs ./hosts/gamma/configuration.nix [ ];
        quirera = mkHost nixosPkgs ./hosts/quirera/configuration.nix [ ];
      };

      homeConfigurations = {
        gamma = mkHome nixosPkgs "marisa" "gamma.nix";
        quirera = mkHome nixosPkgs "marisa" "quirera.nix";
        tau = mkHome homePkgs "marisa" "tau.nix";
        pi = mkHome piPkgs "marisa" "pi.nix";
      };

      devShells.${nixosPkgs.system} = {
        default =
          let
            pkgs = nixosPkgs;
          in
          import ./shell.nix { inherit pkgs; };
      };

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    };
}
