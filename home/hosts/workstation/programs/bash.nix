{ ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      "build-workstation" = "sudo nixos-rebuild switch --flake /etc/nixos/#workstation";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec start-hyprland
      fi
    '';
  };
}
