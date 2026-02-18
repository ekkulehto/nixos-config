{ inputs, mkHost, ... }:

{
  flake.nixosConfigurations.desktop = mkHost {
    hostModule = ../hosts/workstation;
    hmUserPath = ../home/users/ekku/workstation;

    specialArgs = {
      autologinUser = "ekku";
    };

    hmExtraSpecialArgs = {
      noctalia = inputs.noctalia;
      llm-agents = inputs.llm-agents;
      nvf = inputs.nvf;
    };
  };
}
