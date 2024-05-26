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
        mkPkgs = pkgs: system: import pkgs{
                inherit system;
                config = {allowUnfree = true; permittedInsecurePackages = [ "nix-2.15.3" ];};
                overlays = [];
            };

		lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = mkPkgs nixpkgs system;
        pkgs-unstable = mkPkgs nixpkgs-unstable system;

	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
                inherit system;
				modules = [./modules/profiles/personal/configuration.nix];
                specialArgs = {
                    inherit pkgs-unstable;
                    inherit pkgs;
                };
			};
		#
		# 	development = lib.nixosSystem {
  #               inherit system;
		# 		modules = [./modules/profiles/development/configuration.nix];
  #               specialArgs = {
  #                   inherit pkgs-unstable;
  #               };
		# 	};
		#
		# 	rpi-server = lib.nixosSystem {
  #               inherit system;
		# 		modules = [./modules/profiles/rpi-server/configuration.nix];
  #               specialArgs = {
  #                   inherit pkgs-unstable;
  #               };
		# 	};
		};
        homeConfigurations = {
			vebly = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
				modules = [./modules/profiles/personal/home.nix];
                extraSpecialArgs = {
                    inherit pkgs-unstable;
                };
			};
        };
	};
}
