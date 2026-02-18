{ enablePermissions ? false }:

if enablePermissions then ''
  ecosystem:enforce_permissions = true

  # Examples:
  # permission = /usr/bin/grim, screencopy, allow
  # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
  # permission = /usr/bin/hyprpm, plugin, allow
'' else ''
  # Permissions (disabled, matches your old config)
  # ecosystem:enforce_permissions = true
  # permission = /usr/bin/grim, screencopy, allow
  # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
  # permission = /usr/bin/hyprpm, plugin, allow
''
