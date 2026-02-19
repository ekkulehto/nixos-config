let
  ekku = "";
  openclaw = "";
in
{
  "secrets/openclaw/telegram-bot-token.age".publicKeys = [ ekku openclaw ];
  "secrets/openclaw/openclaw.env.age".publicKeys = [ ekku openclaw ];
}
