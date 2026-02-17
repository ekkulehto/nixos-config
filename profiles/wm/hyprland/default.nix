{ pkgs, ... }:

{
  # Hyprland configuration is handled in home manager
  # This module just ensures Hyprland is available at the system level
  
  # The actual configuration is in modules/home-manager/programs/extra/desktop/hyprland/
  # which gets imported by the desktop profile
}
