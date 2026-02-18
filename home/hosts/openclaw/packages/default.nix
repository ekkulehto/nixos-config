{ pkgs, llm-agents, ... }:

{
  llmPackages = with llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    openclaw
  ];
}
