{ config, lib, ... }:

let
  cfg = config.services.openclaw;
  rootSecrets = ../../../../../secrets
in
{
  config = lib.mkIf cfg.enable {
    age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    age.secrets.telegram-bot-token = {
      file = rootSecrets + "/openclaw/telegram-bot-token.age";
      owner = cfg.user;
      group = cfg.group;
      mode = "0400";
    };

    age.secrets.openclaw-env = {
      file = rootSecrets + "/openclaw/openclaw.env.age";
      owner = cfg.user;
      group = cfg.group;
      mode = "0400";
    };
  };
}
