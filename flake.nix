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
        minimal-tmux = {
            url = "github:niksingh710/minimal-tmux-status";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = inputs @ {self, nixpkgs, home-manager, nixpkgs-unstable,minimal-tmux, ...}: 
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
        specialArgs = {inherit pkgs pkgs-unstable fn;};

	in {
		nixosConfigurations = {
			thinkpad = lib.nixosSystem {
                inherit system;
				modules = [./systems/thinkpad];
                inherit specialArgs;
			};
			hp = lib.nixosSystem {
                inherit system;
				modules = [./systems/hp];
                inherit specialArgs;
			};
			wsl = lib.nixosSystem {
                inherit system;
				modules = [./systems/thinkpad];
                inherit specialArgs;
			};
		};
        homeConfigurations = {
			vebly = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
				modules = [
                    ./users/vebly
                    inputs.nvim.homeManagerModule
				];
                extraSpecialArgs = {
                    inherit pkgs-unstable pkgs fn minimal-tmux;
                };
			};
			klee = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
				modules = [
                    ./users/klee
                    inputs.nvim.homeManagerModule
				];
                extraSpecialArgs = {
                    inherit pkgs-unstable pkgs fn minimal-tmux;
                };
			};
            
        };
	};
}
