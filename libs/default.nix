{ inputs }:
let
  libs = ( import ./default.nix ) { inherit inputs; };
  outputs = inputs.self.outputs;
in {

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

  # mkHome = pkgs: username:
  # let
  #   homeDirectory = "/home/${username}";
  # in {
  #   inputs.home-manager.lib.homeManagerConfiguration = {
  #     inherit pkgs;
  #     extraSpecialArgs = {
  #       inherit inputs libs outputs;
  #     };
  #     modules = [
  #       ./../modules/home
  #       {
  #         programs.home-manager.enable = true;
  #         home = {
  #           inherit username homeDirectory;
  #           stateVersion = "23.11";
  #         };
  #       }
  #     ];
  #   };
  # };
}
