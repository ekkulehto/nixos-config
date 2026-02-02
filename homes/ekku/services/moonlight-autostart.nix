{ pkgs, lib, ... }:

let
  moonlight = lib.getExe pkgs.moonlight-qt;

  host = "192.168.8.3";
  app  = "Desktop";

  moonlightLoop = pkgs.writeShellScript "moonlight-autostream" ''
    set -euo pipefail

    # Odota että Wayland/Hyprland on oikeasti pystyssä
    while [ -z "''${WAYLAND_DISPLAY:-}" ]; do
      sleep 1
    done

    while true; do
      ${moonlight} stream ${host} -app "${app}" -fullscreen || true
      sleep 2
    done
  '';
in
{
  home.packages = [ pkgs.moonlight-qt ];

  systemd.user.services.moonlight-autostream = {
    Unit = {
      Description = "Moonlight autostream to 192.168.8.3";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = moonlightLoop;
      Restart = "always";
      RestartSec = 2;

      KillMode = "mixed";
      TimeoutStopSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
