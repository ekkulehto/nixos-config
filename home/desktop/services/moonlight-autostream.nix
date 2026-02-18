{ pkgs, lib, ... }:

let
  host = "192.168.8.3";
  app  = "Desktop";
in
{
  systemd.user.services.moonlight-autostream = {
    Unit = {
      Description = "Moonlight Autostream";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.moonlight-qt} stream \"${host}\" \"${app}\" --quit-after";

      Restart = "always";
      RestartSec = "2s";

      Environment = [
        "SDL_VIDEODRIVER=x11"
        "QT_QPA_PLATFORM=xcb"
        "QT_AUTO_SCREEN_SCALE_FACTOR=0"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
