{ lib, enableMoonlightAutostream ? false }:

{
  "exec-once" =
    lib.optionals enableMoonlightAutostream [
      "systemctl --user start moonlight-autostream.service"
    ];
}
