{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    
    # Use extraConfig to add source directives that include all other config files
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  # Create symlinks for all the individual config files
  xdg.configFile."hypr/monitors.conf".text = builtins.readFile ./monitors.conf;
  xdg.configFile."hypr/env.conf".text = builtins.readFile ./env.conf;
  xdg.configFile."hypr/look-and-feel.conf".text = builtins.readFile ./look-and-feel.conf;
  xdg.configFile."hypr/input.conf".text = builtins.readFile ./input.conf;
  xdg.configFile."hypr/permissions.conf".text = builtins.readFile ./permissions.conf;
  xdg.configFile."hypr/windows-and-workspaces.conf".text = builtins.readFile ./windows-and-workspaces.conf;
  xdg.configFile."hypr/keybindings.conf".text = builtins.readFile ./keybindings.conf;
  xdg.configFile."hypr/autostart.conf".text = builtins.readFile ./autostart.conf;
}
