{
	description = "My first flake!";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = {self, nixpkgs, home-manager, nixpkgs-unstable, ...}: 
	let
		lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
                inherit system;
				modules = [./configuration.nix];
                specialArgs = {
                    inherit pkgs-unstable;
                };
			};
		};
        homeConfigurations = {
			vebly = home-manager.lib.homeManagerConfiguration{
                inherit pkgs;
				modules = [./home.nix];
                extraSpecialArgs = {
                    inherit pkgs-unstable;
                };
			};
        };
	};
}
