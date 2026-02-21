{ config, ... }:

let
  svc = config.services.openclaw;
in

{
  age.secrets.telegram-bot-token = {
    file = ../../../../../secrets/openclaw/telegram-bot-token.age;
    owner = svc.user;
    group = svc.group;
    mode = "0400";
  };

  age.secrets.openclaw-env = {
    file = ../../../../../secrets/openclaw/openclaw.env.age;
    owner = svc.user;
    group = svc.group;
    mode = "0400";
  };
}
