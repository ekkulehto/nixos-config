{ inputs, mkHost, ... }:

{
  flake.nixosConfigurations.desktop = mkHost {
    hostModule = ../hosts/desktop;
    hmUserPath = ../home/users/ekku/desktop;

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
