{
	description = "Nix Configuration";

	inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        nvim-custom = { 
            url = "github:SegfaultSorcery/nvim-flake"; 
            inputs.nixpkgs.follows = "nixpkgs";
        };
        awesome-config = {
            url = "github:SegfaultSorcery/awesome-config";
            flake = false;
        };
        minimal-tmux = {
            url = "github:niksingh710/minimal-tmux-status";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        gdb-peda = {
            url = "github:longld/peda";
            flake = false;
        };
        wallpapers = {
            url = "github:SegfaultSorcery/wallpapers";
            flake = false;
        };
	};

	outputs = inputs @ {self, nixpkgs, home-manager, nixpkgs-unstable, nixos-hardware, minimal-tmux, nvim-custom, ...}: 
	let
        mkPkgs = pkgs: system: import pkgs{
                inherit system;
                config = {
                    allowUnfree = true; 
                    permittedInsecurePackages = [ ];
                };
                overlays = [nvim-custom.overlays.default];
        };
        var = {
            path.root = "/home/nixos/nixos-config";
            wallpaperPath = "~/Pictures/Wallpapers";
        };

	lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = mkPkgs nixpkgs system;
        pkgs-unstable = mkPkgs nixpkgs-unstable system;
        fn = import ./modules/flake/utils {inherit lib;};
        specialArgs = {inherit pkgs pkgs-unstable var fn inputs;};
        sharedModules = [
            home-manager.nixosModules.home-manager
            {
                home-manager = {
                    useUserPackages = true;
                    extraSpecialArgs = specialArgs;
                };
            }
        ];
	in {
		nixosConfigurations = {
			thinkpad = lib.nixosSystem {
                inherit system;
				modules = sharedModules ++ [./hosts/thinkpad];
                inherit specialArgs;
			};
			hp = lib.nixosSystem {
                inherit system;
				modules = sharedModules ++ [./hosts/hp];
                inherit specialArgs;
			};
			desktop = lib.nixosSystem { 
		inherit system;
			modules = sharedModules ++ [./hosts/desktop];
		inherit specialArgs;
			};
			wsl = lib.nixosSystem {
                inherit system;
				modules = sharedModules ++ [./hosts/wsl];
                inherit specialArgs;
			};
		};
	};
}
