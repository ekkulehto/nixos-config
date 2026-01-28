{ pkgs, ... }:

{
  users.users.ekku = {
    isNormalUser = true;
    extraGroups = [ "wheel" "i2c" ];
    packages = with pkgs; [
      tree
    ];
  };
}
