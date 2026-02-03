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

      # Odota että user runtime on olemassa
      while [ -z "''${XDG_RUNTIME_DIR:-}" ]; do
        sleep 1
      done

      # Odota että XWayland/X11 socket ilmestyy (xcb tarvitsee tämän)
      while [ ! -S /tmp/.X11-unix/X0 ] && [ ! -S /tmp/.X11-unix/X1 ] && [ ! -S /tmp/.X11-unix/X2 ]; do
        sleep 1
      done

      # Aseta DISPLAY sen mukaan mikä socket löytyi
      if [ -S /tmp/.X11-unix/X0 ]; then export DISPLAY=":0"; fi
      if [ -S /tmp/.X11-unix/X1 ]; then export DISPLAY=":1"; fi
      if [ -S /tmp/.X11-unix/X2 ]; then export DISPLAY=":2"; fi

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
