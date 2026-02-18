{ pkgs, llmAgents, ... }:

let
  basePackages = with pkgs; [
    ripgrep
    fastfetch
    vim
    wget
  ];

  llmPackages = with llmAgents.packages.${pkgs.stdenv.hostPlatform.system}; [
    mistral-vibe
  ];
in
{
  home.packages = basePackages ++ llmPackages;
}
