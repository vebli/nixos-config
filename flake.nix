{
	description = "Nix Configuration";

	inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        sops-nix.url = "github:Mic92/sops-nix";
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
        nix-matlab = {
            inputs.nixpkgs.follows = "nixpkgs";
            url = "gitlab:doronbehar/nix-matlab";
        };
	};

	outputs = inputs @ {self, nixpkgs, nixpkgs-unstable, nixos-hardware, minimal-tmux, nvim-custom, ...}: 
	let
        mkPkgs = pkgs: system: import pkgs{
                inherit system;
                config = {
                    allowUnfree = true; 
                    permittedInsecurePackages = [ ];
                };
                overlays = [nvim-custom.overlays.default inputs.nix-matlab.overlay];
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
            inputs.home-manager.nixosModules.home-manager
            {
                home-manager = {
                    useUserPackages = true;
                    extraSpecialArgs = specialArgs;
                };
            }
            inputs.sops-nix.nixosModules.sops {
                sops = {
                    defaultSopsFile = ./secrets/secrets.yaml;
                    defaultSopsFormat= "yaml";
                    age.keyFile = "/home/user/.config/sops/age/keys.txt";
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
			server = lib.nixosSystem { 
		inherit system;
			modules = sharedModules ++ [./hosts/server];
		inherit specialArgs;
			};
		};
	};
}
