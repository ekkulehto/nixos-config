{ confif, pkgs, ... }:

{
  home.username = "ekku";
  home.stateVersion = "25.11";

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ekku Lehto";
        email = "ekkulehto@proton.me";
      };
      init.defaultBranch = "main";
    };
  };

  programs.bash = {
    enable = true;
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };
}
