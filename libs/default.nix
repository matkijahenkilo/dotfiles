{ inputs }:
let
  libs = ( import ./default.nix ) { inherit inputs; };
  outputs = inputs.self.outputs;
in rec {

  pkgsFor = sys: inputs.nixpkgs.legacyPackages.${sys};

  mkHost = config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs libs;
      };
      modules = [
        config
      ];
    };

  mkHome = sys: username:
  let
    homeDirectory = "/home/${username}";
  in {
    inputs.home-manager.lib.homeManagerConfiguration = {
      pkgs = pkgsFor sys;
      extraSpecialArgs = {
        inherit inputs libs outputs;
      };
      modules = [
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            backupFileExtension = "backup";
            users = {
              username = import ./../modules/home;
            };
          };
          home = {
            inherit username homeDirectory;
            stateVersion = "23.11";
          };
          programs.home-manager = {
            enable = true;
          };
        }
      ];
    };
  };
}
