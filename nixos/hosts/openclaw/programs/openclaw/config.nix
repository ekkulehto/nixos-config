{ ... }:

{
  services.openclaw.config = {
    gateway = {
      mode = "local";
      bind = "loopback";
      auth = {
        mode = "token";
        token = "\${OPENCLAW_GATEWAY_TOKEN}";
      };
    };

    tools = {
      profile = "messaging";
      deny = [
        "group:automation"
        "group:runtime"
        "group:fs"
        "sessions_spawn"
        "sessions_send"
      ];
      fs = { workspaceOnly = true; };
      exec = { security = "deny"; ask = "always"; };
      elevated = { enabled = false; };
    };

    channels.telegram = {
      tokenFile = "/run/agenix/telegram-bot-token";
      dmPolicy = "pairing";
      groups = { "*" = { requireMention = true; }; };
    };

    agents.defaults = {
      userTimezone = "Europe/Helsinki";

      model = {
        primary = "mistral/mistral-vibe-cli-with-tools";
      };

      models = {
        "mistral/mistral-vibe-cli-with-tools" = {
          alias = "vibe";
        };
      };
    };
  };
}
