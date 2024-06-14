{
	description = "Nix Configuration";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nvim = { 
            url = "github:SegfaultSorcery/nvim-flake"; 
            inputs.home-manager.follows = "home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = {self, nixpkgs, home-manager, nixpkgs-unstable, nvim, ...}: 
	let
        mkPkgs = pkgs: system: import pkgs{
                inherit system;
                config = {allowUnfree = true; permittedInsecurePackages = 
                [ 
                "nix-2.15.3" 
                "electron-25.9.0"
                ];};
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
                    inherit pkgs-unstable;
                    inherit pkgs;
                    inherit fn;
                };
			};
		};
        homeConfigurations = {
			vebly = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
				modules = [./profiles/personal/home.nix];
                extraSpecialArgs = {
                    inherit pkgs-unstable;
                    inherit fn;
                    inherit nvim;
                };
			};
        };
	};
}
