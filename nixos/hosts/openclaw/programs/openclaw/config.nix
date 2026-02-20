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
      enabled = true;

      tokenFile = "\${CREDENTIALS_DIRECTORY}/telegram-bot-token";

      configWrites = false;

      dmPolicy = "allowlist";
      allowFrom = [ 1653058581 ];

      groups = {
        "*" = { requireMention = true; };
      };
    };

    models = {
      mode = "merge";
      providers = {
        mistralvibe = {
          baseUrl = "https://api.mistral.ai/v1";
          api = "openai-completions";
          apiKey = "\${MISTRAL_API_KEY}";

          models = [
            {
              id = "mistral-vibe-cli-latest";
              name = "Mistral Vibe CLI Latest (Devstral 2)";
            }
          ];
        };
      };
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
