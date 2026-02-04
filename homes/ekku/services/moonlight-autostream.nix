{ pkgs, lib, ... }:

let
  host = "192.168.8.3";
  app  = "Desktop";
in
{
  home.packages = [ pkgs.moonlight-qt ];

  systemd.user.services.moonlight-autostream = {
    Unit = {
      Description = "Moonlight Autostream (Native Wayland)";
      After = [ "graphical-session.target" "network-online.target" ];
      Wants = [ "network-online.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      # Pieni viive
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
      
      # Käynnistyskomento
      ExecStart = ''
        ${lib.getExe pkgs.moonlight-qt} stream "${host}" "${app}" --quit-after
      '';

      Restart = "always";
      RestartSec = "3s";
      
      Environment = [
        "SDL_VIDEODRIVER=wayland"
        "QT_QPA_PLATFORM=wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR=1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION=1"
      ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
