{ pkgs, llm-agents, ... }:

let
  basePackages = with pkgs; [
    ripgrep
    fastfetch
    vim
    wget
  ];

  llmPackages = with llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    mistral-vibe
  ];
in
{
  home.packages = basePackages ++ llmPackages;
}
