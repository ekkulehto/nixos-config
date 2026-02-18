{ ... }:

{
  imports = [
    ./preview.nix
    ./keymap.nix
  ];

  programs.yazi.enable = true;
}
