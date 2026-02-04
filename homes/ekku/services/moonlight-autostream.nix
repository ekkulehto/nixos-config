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
      # Käynnistyy vasta kun graafinen työpöytä (Hyprland) on valmis
      After = [ "graphical-session.target" "network-online.target" ];
      Wants = [ "network-online.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      # Pieni viive varmistamaan, että Wayland-socket on valmis Hyprlandin käynnistyessä
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
      
      # Käynnistetään Moonlight.
      # --quit-after: Sulkee prosessin jos striimi katkeaa, jolloin systemd käynnistää sen puhtaasti uudelleen.
      ExecStart = ''
        ${lib.getExe pkgs.moonlight-qt} stream "${host}" "${app}" --quit-after
      '';

      Restart = "always";
      RestartSec = "3s";
      
      # Pakotetaan Moonlight käyttämään natiivia Waylandia.
      # Tämä on kriittistä 5120x1440 @ 100Hz suorituskyvylle.
      Environment = {
        "SDL_VIDEODRIVER" = "wayland";
        "QT_QPA_PLATFORM" = "wayland";
        "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
        "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
      };
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
