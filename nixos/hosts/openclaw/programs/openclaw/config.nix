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

      # ÄLÄ blokkaa sessions_spawn globaalisti jos haluat main -> research delegoinnin.
      deny = [
        "group:automation"
        "sessions_send"
      ];

      elevated = { enabled = false; };

      # SearXNG skill on binääri -> exec tarvitaan.
      # Headless + Telegram: pidä allowlist ja kysy ekalla kerralla (persistoi allowlistiin).
      exec = {
        host = "gateway";
        security = "allowlist";
        ask = "always";
      };

      # Defense-in-depth: sub-agentit eivät saa "kaikkea oletuksena".
      # Docs: sub-agentit saavat muuten laajan tool-pinnan ellei rajata. :contentReference[oaicite:5]{index=5}
      subagents = {
        tools = {
          allow = [ "exec" "web_fetch" ];
          deny = [
            "group:automation"
            "group:fs"
            "bash"
            "process"
            "web_search"
            "browser"
            "canvas"
            "nodes"
            "image"
            "message"
            "gateway"
            "cron"
          ];
        };
      };
    };

    channels.telegram = {
      enabled = true;
      tokenFile = "\${CREDENTIALS_DIRECTORY}/telegram-bot-token";
      # Required for Telegram-driven pairing/session state (e.g. subagent spawn auth context).
      configWrites = true;
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

      model.primary = "mistral/mistral-vibe-cli-latest";

      models = {
        "mistral/mistral-vibe-cli-latest" = { alias = "vibe"; };
        "mistral/mistral-vibe-cli-with-tools" = { alias = "vibe-with-tools"; };
      };

      # Ei nested-spawneja (turvallisempi ja yksinkertaisempi)
      subagents = {
        maxSpawnDepth = 1;
        maxChildrenPerAgent = 3;
        maxConcurrent = 3;
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

          # Orkestroija tarvitsee tämän, muuten ei voi delegoida researchille.
          allow = [ "sessions_spawn" "agents_list" "exec" ];

          deny = [
            "group:automation"
            "group:fs"
            "group:web"
          ];

          elevated = { enabled = false; };
        };

        subagents = {
          allowAgents = [ "research" "coder" ];
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
          profile = "minimal";
          allow = [ "exec" "web_fetch" ];
          deny = [
            "group:automation"
            "group:fs"
            "bash"
            "process"
            "web_search"
            "browser"
            "canvas"
            "nodes"
            "image"
            "message"
          ];
          elevated = { enabled = false; };
        };

        model.primary = "mistral/mistral-vibe-cli-with-tools";

        groupChat = {
          mentionPatterns = [ "@openclaw" "openclaw" ];
        };
      }

      {
        id = "coder";
        name = "Coder";
        workspace = "~/.openclaw/workspace-coder";

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
