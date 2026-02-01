{ pkgs, ... }:

 {
   home.packages = with pkgs; [
    nil
    kdePackages.qtdeclarative
   ];
 }
