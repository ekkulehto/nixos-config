{ ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      "build-desktop" = "sudo nixos-rebuild switch --flake /etc/nixos/#desktop";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };
}
