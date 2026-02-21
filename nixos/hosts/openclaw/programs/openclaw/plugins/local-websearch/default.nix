{ pkgs, inputs }:
let
  skillsRepo = inputs.openclaw-skills;
  upstreamDir = "${skillsRepo}/skills/stperic/local-websearch";

  # wrapper bin: searxng_search -> python3 upstream searxng_search.py
  searxng_search = pkgs.writeShellApplication {
    name = "searxng_search";
    runtimeInputs = [ pkgs.python3 ];
    text = ''
      exec python3 ${upstreamDir}/searxng_search.py "$@"
    '';
  };

  # generate a OpenClaw-friendly SKILL.md in the store
  skillDir = pkgs.runCommand "openclaw-skill-local-websearch" {} ''
    mkdir -p "$out"
    cat > "$out/SKILL.md" <<'EOF'
---
name: searxng
description: Search the web using self-hosted SearXNG (requires SEARXNG_URL). Returns JSON.
metadata:
  openclaw:
    requires:
      bins: ["searxng_search"]
      env: ["SEARXNG_URL"]
---

# SearXNG Web Search

Use this skill when the user asks you to search the web / look something up.

## Usage

- searxng_search "query"
- searxng_search "query" --count 10
- searxng_search "query" --lang fi
EOF
  '';
in
{
  name = "searxng";
  inherit skillDir;
  package = searxng_search;

  # Link into main + research so Telegram/default agent can use it directly,
  # while research can still use it when delegated.
  targets = [ "main" "research" ];
}
