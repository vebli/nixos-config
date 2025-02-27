{
	description = "Nix Configuration";

	inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        sops-nix.url = "github:Mic92/sops-nix";
        nvim-custom = { 
            url = "github:vebli/nvim-nvf"; 
            inputs.nixpkgs.follows = "nixpkgs";
        };
        awesome-config = {
            url = "github:vebli/awesome-config";
            flake = false;
        };
        minimal-tmux = {
            url = "github:niksingh710/minimal-tmux-status";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        wallpapers = {
            url = "github:vebli/wallpapers";
            flake = false;
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
                overlays = [nvim-custom.overlays.default ];
        };
        var = {
            system = "x86_64-linux";
            path.root = "/etc/nixos/";
            path.wallpapers= "~/Pictures/Wallpapers/";
        };

        lib = nixpkgs.lib;
        system = var.system;
        pkgs = mkPkgs nixpkgs system;
        pkgs-unstable = mkPkgs nixpkgs-unstable system;
        fn = import ./modules/flake/utils {inherit pkgs lib;};
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
                     age.keyFile = "/home/vebly/.config/sops/age/keys.txt";
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
