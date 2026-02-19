{ inputs, mkHost, ... }:

{
  flake.nixosConfigurations.openclaw = mkHost {
    hostModule = ../hosts/openclaw;
    hmUserPath = ../home/users/ekku/openclaw;

    specialArgs = {
      autologinUser = "ekku";
    };

    hmExtraSpecialArgs = {
      llm-agents = inputs.llm-agents;
      nvf = inputs.nvf;
    };

    extraModule = {
      imports = [ 
        inputs.determinate.nixosModules.default 
      ];

      nixpkgs.overlays = [
        inputs.nix-openclaw.overlays.default
      ];
    };
  };
}
