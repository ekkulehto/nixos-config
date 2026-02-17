{ pkgs, ... }:

{
  users.users.openclaw = {
    isNormalUser = true;
    packages = with pkgs; [
      tree
    ];
  };
}
