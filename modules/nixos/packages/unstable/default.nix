{ pkgs, llm-agents, ... }:

{
  environment.systemPackages = with llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      mistral-vibe
  ];
}
