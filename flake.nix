{
	description = "Nix Configuration";

	inputs = {
	nixpkgs.url = "nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        nvim = { 
            url = "github:SegfaultSorcery/nvim-flake"; 
            inputs.nixpkgs.follows = "nixpkgs";
        };
        minimal-tmux = {
            url = "github:niksingh710/minimal-tmux-status";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = inputs @ {self, nixpkgs, home-manager, nixpkgs-unstable, nixos-hardware, minimal-tmux, nvim, ...}: 
	let
        mkPkgs = pkgs: system: import pkgs{
                inherit system;
                config = {
                    allowUnfree = true; 
                    permittedInsecurePackages = [ ];
                };
                overlays = [];
        };
        var = {
            path.root = "/home/nixos/nixos-config";
        };

	lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = mkPkgs nixpkgs system;
        pkgs-unstable = mkPkgs nixpkgs-unstable system;
        fn = import ./modules/flake/utils {inherit lib;};
        specialArgs = {inherit pkgs pkgs-unstable var fn nvim nixos-hardware;};
        sharedModules = [
            home-manager.nixosModules.home-manager
            {
                home-manager = {
                    useUserPackages = true;
                    extraSpecialArgs = specialArgs // {inherit minimal-tmux;};
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
			wsl = lib.nixosSystem {
                inherit system;
				modules = sharedModules ++ [./hosts/wsl];
                inherit specialArgs;
			};
		};
	};
}
