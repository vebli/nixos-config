{
  description = "Nix Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
    nvim-custom.url = "github:vebli/nvim-lazy"; 
    dmenu-custom.url = "github:vebli/dmenu-nix";
    tmux-custom.url = "github:vebli/tmux-nix";
    wallpapers = {
      url = "github:vebli/wallpapers";
      flake = false;
    };
    nix-matlab.url = "gitlab:doronbehar/nix-matlab";
    awesome-config = {
      url = "github:vebli/awesome-config";
      flake = false;
    };
  };

  outputs = inputs @ {self, nixpkgs, nixpkgs-unstable, nixos-hardware,  ...}: 
    let
      nixpkgsConfig = {
        config = {
          allowUnfree = true; 
          permittedInsecurePackages = [ ];
        };
        overlays = with inputs; [
          nvim-custom.overlays.default 
          tmux-custom.overlays.default
          dmenu-custom.overlays.default
          nix-matlab.overlay
        ];
      };
      var = {
        path.root = "/etc/nixos/";
        path.wallpapers= "~/Pictures/Wallpapers/";
      };

      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable (nixpkgsConfig // {inherit system;});
      specialArgs = {inherit pkgs-unstable var inputs;};
      sharedModules = [
          ({...}: {
           nixpkgs.config = nixpkgsConfig.config;
           nixpkgs.overlays = nixpkgsConfig.overlays;
           })

        ./modules/flake/utils

        inputs.home-manager.nixosModules.home-manager {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    in {
      nixosConfigurations = {
        thinkpad = lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [./hosts/thinkpad];
          inherit specialArgs;
        };
        hp = lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [./hosts/hp];
          inherit specialArgs;
        };
        desktop = lib.nixosSystem { 
          system = "x86_64-linux";
          modules = sharedModules ++ [./hosts/desktop];
          inherit specialArgs;
        };
        wsl = lib.nixosSystem {
          system = "x86_64-linux";
          modules = sharedModules ++ [./hosts/wsl];
          inherit specialArgs;
        };
        server = lib.nixosSystem { 
          system = "x86_64-linux";
          modules = sharedModules ++ [./hosts/server];
          inherit specialArgs;
        };
      };
    };
}
