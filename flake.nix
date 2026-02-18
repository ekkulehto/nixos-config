{
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
     };
     
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
     };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
    };
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {
        autologinUser = "ekku";
      };

      modules = [
        { 
          nixpkgs.hostPlatform = system; 
        }

        ./hosts/desktop
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit pkgsUnstable;
              noctalia = inputs.noctalia;
              llm-agents = inputs.llm-agents;
              nvf = inputs.nvf;
            };

            users.ekku = import (./home/users/ekku/desktop);
            backupFileExtension = "backup";
          };
        }
      ];
    };

    nixosConfigurations.openclaw = nixpkgs.lib.nixosSystem {
      specialArgs = {
        autologinUser = "ekku";
      };

      modules = [
        { 
          nixpkgs.hostPlatform = system; 
        }

        ./hosts/openclaw
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit pkgsUnstable;
              llm-agents = inputs.llm-agents;
              nvf = inputs.nvf;
            };

            users.ekku = import (./home/users/ekku/openclaw);
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
