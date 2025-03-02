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
    tmux-custom = {
      url = "github:vebli/tmux-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awesome-config = {
      url = "github:vebli/awesome-config";
      flake = false;
    };
    wallpapers = {
      url = "github:vebli/wallpapers";
      flake = false;
    };
    nix-matlab = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
    };
  };

  outputs = inputs @ {self, nixpkgs, nixpkgs-unstable, nixos-hardware,  ...}: 
    let
      mkPkgs = pkgs: system: import pkgs{
        inherit system;
        config = {
          allowUnfree = true; 
          permittedInsecurePackages = [ ];
        };
        overlays = with inputs; [
          nvim-custom.overlays.default 
          tmux-custom.overlays.default
          nix-matlab.overlay
        ];
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
