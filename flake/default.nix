{ inputs, ... }:

let
  system = "x86_64-linux";

  pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit system;
  };

  mkHost =
    { hostModule
    , hmUserPath
    , hmExtraSpecialArgs ? {}
    , specialArgs ? {}
    , extraModule ? {}
    }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = specialArgs // { inherit inputs; };

      modules = [
        { nixpkgs.hostPlatform = system; }

        extraModule

        hostModule

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs =
              { inherit inputs pkgsUnstable; }
              // hmExtraSpecialArgs;

            users.ekku = import hmUserPath { inherit inputs; };
            backupFileExtension = "backup";
          };
        }
      ];
    };
in
{
  imports = [
    ./workstation.nix
    ./openclaw.nix
  ];

  _module.args = {
    inherit system pkgsUnstable mkHost;
  };
}
