{ pkgs, ... }:

{
  users.users.openclaw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "i2c" ];
    packages = with pkgs; [
      tree
    ];
  };
}
