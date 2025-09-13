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

    nixcord = {
      url = "github:kaylorben/nixcord";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tsih-robo-ktx.url = "github:matkijahenkilo/tsih-robo-ktx";
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
          (final: prev: {
            davinci-resolve-studio = prev.davinci-resolve-studio.override (final: {
              buildFHSEnv =
                a:
                (final.buildFHSEnv (
                  a
                  // {
                    extraBwrapArgs = a.extraBwrapArgs ++ [
                      "--bind /run/opengl-driver/etc/OpenCL /etc/OpenCL"
                    ];
                  }
                ));
            });
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
        pi = mkHost piPkgs ./hosts/pi/configuration.nix [
          nixos-hardware.nixosModules.raspberry-pi-3
        ];
      };

      homeConfigurations = {
        gamma = mkHome nixosPkgs "marisa" "gamma.nix";
        quirera = mkHome nixosPkgs "marisa" "quirera.nix";
        quireraNana = mkHome nixosPkgs "nanako" "quireraNana.nix";
        tau = mkHome homePkgs "marisa" "tau.nix";
      };

      devShells = {
        ${nixosPkgs.system}.default =
          let
            pkgs = nixosPkgs;
          in
          import ./shell.nix { inherit pkgs; };
        ${piPkgs.system}.default =
          let
            pkgs = piPkgs;
          in
          import ./shell.nix { inherit pkgs; };
      };

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    };
}
