{ pkgs, lib, ... }:

let
  host = "192.168.8.3";
  app  = "Desktop";
in
{
  home.packages = [ pkgs.moonlight-qt ];

  systemd.user.services.moonlight-autostream = {
    Unit = {
      Description = "Moonlight Autostream (X11 Mode)";
      # Käynnistyy graafisen session mukana
      After = [ "graphical-session.target" "network-online.target" ];
      Wants = [ "network-online.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      # XWayland saattaa käynnistyä pienellä viiveellä Hyprlandissa,
      # joten sleep on tässä X11-tilassa vielä tärkeämpi kuin Waylandissa.
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
      
      # Käynnistyskomento (sama kuin aiemmin)
      ExecStart = ''
        ${lib.getExe pkgs.moonlight-qt} stream "${host}" "${app}" --quit-after
      '';

      Restart = "always";
      RestartSec = "3s";
      
      # PAKOTETAAN X11 / XCB
      Environment = [
        "SDL_VIDEODRIVER=x11"
        "QT_QPA_PLATFORM=xcb"
        # Jos kuva skaalautuu väärin XWaylandissa, voit kokeilla muuttaa tätä (0 tai 1)
        "QT_AUTO_SCREEN_SCALE_FACTOR=0"
      ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
