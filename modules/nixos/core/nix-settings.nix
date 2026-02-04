{ lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Allow specific unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "grayjay" ];
}
