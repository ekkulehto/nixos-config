{ ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      "build-openclaw" = "sudo nixos-rebuild switch --flake /etc/nixos/#openclaw";
    };
  };
}
