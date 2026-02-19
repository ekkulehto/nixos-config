{ ... }:

{
  age.secrets.telegram-bot-token = {
    file = ../../../../../secrets/openclaw/telegram-bot-token.age;
    mode = "0400";
  };

  age.secrets.openclaw-env = {
    file = ../../../../../secrets/openclaw/openclaw.env.age;
    mode = "0400";
  };
}
