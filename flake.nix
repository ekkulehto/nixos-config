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
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, noctalia, ... }:
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
              inherit pkgsUnstable noctalia;
              enableNoctalia = true;
            };

            users.ekku = import ./homes/ekku;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
