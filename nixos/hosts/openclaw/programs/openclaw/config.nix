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
        "sessions_spawn"
        "sessions_send"
      ];
      elevated = { enabled = false; };
    };

    channels.telegram = {
      enabled = true;
      tokenFile = "\${CREDENTIALS_DIRECTORY}/telegram-bot-token";
      configWrites = false;
      dmPolicy = "allowlist";
      allowFrom = [ 1653058581 ];
      groups = { "*" = { requireMention = true; }; };
    };

    models = {
      mode = "merge";
      providers = {
        mistral = {
          baseUrl = "https://api.mistral.ai/v1";
          api = "openai-completions";
          apiKey = "\${MISTRAL_API_KEY}";

          models = [
            { id = "mistral-vibe-cli-latest";      name = "Mistral Vibe CLI Latest"; }
            { id = "mistral-vibe-cli-with-tools";  name = "Mistral Vibe CLI With Tools"; }
          ];
        };
      };
    };

    agents.defaults = {
      userTimezone = "Europe/Helsinki";

      # keep your existing aliases
      model.primary = "mistral/mistral-vibe-cli-latest";

      models = {
        "mistral/mistral-vibe-cli-latest" = { alias = "vibe"; };
        "mistral/mistral-vibe-cli-with-tools" = { alias = "vibe-with-tools"; };
      };

    };

    agents.list = [
      {
        id = "main";
        default = true;
        name = "Main";
        workspace = "~/.openclaw/workspace";

        tools = {
          profile = "messaging";
          deny = [
            "group:automation"
            "group:runtime"
            "group:fs"
            "group:web"
            "sessions_spawn"
          ];
          elevated = { enabled = false; };
        };

        model.primary = "mistral/mistral-vibe-cli-latest";

        groupChat = {
          mentionPatterns = [ "@openclaw" "openclaw" ];
        };
      }

      {
        id = "research";
        name = "Research";
        workspace = "~/.openclaw/workspace-research";

        tools = {
          profile = "full";
          deny = [
            "group:automation"
            "group:fs"
            "bash"
            "process"
            "sessions_spawn"
          ];
          allow = [ "exec" "web_fetch" ];
          elevated = { enabled = false; };
        };

        # typically use with-tools here (if you want tool-calling bias)
        model.primary = "mistral/mistral-vibe-cli-with-tools";

        groupChat = {
          mentionPatterns = [ "@openclaw" "openclaw" ];
        };
      }

      {
        id = "coder";
        name = "Coder";
        workspace = "~/.openclaw/workspace-coder";

        # Coder: runtime tools allowed, but you’ll enforce sandbox via your systemd hardening + (optional) OpenClaw sandbox config.
        tools = {
          profile = "coding";
          deny = [ "group:automation" ];
        };

        model.primary = "mistral/mistral-vibe-cli-with-tools";

        groupChat = {
          mentionPatterns = [ "@openclaw" "openclaw" ];
        };
      }
    ];
  };
}
