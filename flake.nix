{
  description = "My personal NixOS and dotfiles configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # zsh-git-prompt was removed from nixpkgs by accident
    nixpkgs-zsh-git-prompt.url = "github:nixos/nixpkgs/4f0dadbf38ee4cf4cc38cbc232b7708fddf965bc";
    # recent versions of davinci doesn't work, keep on v20.0.1
    nixpkgs-davinci.url = "github:nixos/nixpkgs/d457818da697aa7711ff3599be23ab8850573a46";
    switch-emulators.url = "github:liberodark/my-flakes";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix";

    treefmt-nix.url = "github:numtide/treefmt-nix";

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

    nixcord.url = "github:kaylorben/nixcord";

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
          rocmSupport = true;
        };
        overlays = import ./overlays/nixosOverlays.nix { pkgs = nixosPkgs; };
      };
      homePkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays = [
          nixgl.overlay
        ]
        ++ import ./overlays/homeOverlays.nix { pkgs = homePkgs; };
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
        gamma = mkHost nixosPkgs ./hosts/gamma/configuration.nix [
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              backupFileExtension = "backup";
              backupCommand = "rm";
              extraSpecialArgs = { inherit inputs nixpkgs self; };
              users.marisa = import ./modules/home/users/gamma.nix;
            };
          }
        ];
        quirera = mkHost nixosPkgs ./hosts/quirera/configuration.nix [
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              backupFileExtension = "backup";
              backupCommand = "rm";
              extraSpecialArgs = { inherit inputs nixpkgs self; };
              users = {
                marisa = import ./modules/home/users/quirera.nix;
                nanako = import ./modules/home/users/nanako.nix;
              };
            };
          }
        ];
        pi = mkHost piPkgs ./hosts/pi/configuration.nix [
          nixos-hardware.nixosModules.raspberry-pi-3
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs nixpkgs self; };
              users.marisa = import ./modules/home/users/pi.nix;
            };
          }
        ];
      };

      devShells = {
        ${nixosPkgs.stdenv.hostPlatform.system}.default = import ./shell.nix { pkgs = nixosPkgs; };
        ${piPkgs.stdenv.hostPlatform.system}.default = import ./shell.nix { pkgs = piPkgs; };
      };

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
      });
    };
}
