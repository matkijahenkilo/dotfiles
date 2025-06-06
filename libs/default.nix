{ inputs }:
let
  libs = (import ./default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
{

  pkgsFor = sys: inputs.nixpkgs.legacyPackages.${sys};

  mkHost =
    pkgs: config: extraModules:
    inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
        inherit inputs outputs libs;
      };
      modules = [
        config
      ] ++ extraModules;
    };

  mkHome =
    pkgs: username: module:
    let
      homeDirectory = "/home/${username}";
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs libs outputs;
      };
      modules = [
        ../modules/home/users/${module}
        {
          programs.home-manager.enable = true;
          home = {
            inherit username homeDirectory;
            stateVersion = "23.11";
          };
        }
      ];
    };
}
