{ pkgs, lib, ... }:

let
  host = "192.168.8.3";
  app  = "Desktop";

  moonlightAutostream = pkgs.writeShellApplication {
    name = "moonlight-autostream";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.moonlight-qt
    ];
    text = ''
      set -euo pipefail

      while [ -z "''${XDG_RUNTIME_DIR:-}" ] || [ -z "''${WAYLAND_DISPLAY:-}" ] || [ -z "''${DISPLAY:-}" ]; do
        sleep 1
      done

      while true; do
        moonlight stream "${host}" "${app}" --display-mode fullscreen || true
        sleep 2
      done
    '';
  };
in
{
  home.packages = [ pkgs.moonlight-qt ];

  systemd.user.services.moonlight-autostream = {
    Unit = {
      Description = "Moonlight autostream to ${host}";
      After = [ "default.target" ];
      PartOf = [ "default.target" ];
    };

    Service = {
      ExecStart = lib.getExe moonlightAutostream;

      Restart = "always";
      RestartSec = 2;

      KillMode = "mixed";
      TimeoutStopSec = 5;

      Environment = [
        "QT_QPA_PLATFORM=xcb"
        "SDL_VIDEODRIVER=x11"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
