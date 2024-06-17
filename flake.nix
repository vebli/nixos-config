{
	description = "Nix Configuration";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nvim = { 
            url = "github:SegfaultSorcery/nvim-flake"; 
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = inputs @ {self, nixpkgs, home-manager, nixpkgs-unstable, ...}: 
	let
        mkPkgs = pkgs: system: import pkgs{
                inherit system;
                config = {
                    allowUnfree = true; 
                    permittedInsecurePackages = [ ];
                };
                overlays = [];
            };

		lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = mkPkgs nixpkgs system;
        pkgs-unstable = mkPkgs nixpkgs-unstable system;
        fn = import ./modules/flake/utils {inherit lib;};
        

	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
                inherit system;
				modules = [./profiles/personal/configuration.nix];
                specialArgs = {
                    inherit pkgs-unstable pkgs fn;
                };
			};
		};
        homeConfigurations = {
			vebly = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
				modules = [
                    ./profiles/personal/home.nix
                    inputs.nvim.homeManagerModule
				];
                extraSpecialArgs = {
                    inherit pkgs-unstable pkgs fn;
                };
			};
        };
	};
}
