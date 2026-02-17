{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    
    # Set the main configuration file
    settings = {
      # Main config that sources all others
      hyprland.conf = builtins.readFile ./hyprland.conf;
      
      # Individual config files
      monitors.conf = builtins.readFile ./monitors.conf;
      env.conf = builtins.readFile ./env.conf;
      look-and-feel.conf = builtins.readFile ./look-and-feel.conf;
      input.conf = builtins.readFile ./input.conf;
      permissions.conf = builtins.readFile ./permissions.conf;
      windows-and-workspaces.conf = builtins.readFile ./windows-and-workspaces.conf;
      keybindings.conf = builtins.readFile ./keybindings.conf;
      autostart.conf = builtins.readFile ./autostart.conf;
    };
  };
}
