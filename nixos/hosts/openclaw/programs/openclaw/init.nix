{ pkgs
, user
, group
, stateDir
, configTemplate
, templatesDir
, skillLinks
, skillsCatalog
, agents
, configWrites ? false
, ...
}:

pkgs.writeShellScript "openclaw-init" ''
  set -euo pipefail

  oc_state="${stateDir}/.openclaw"

  install -d -m 0700 -o ${user} -g ${group} "${stateDir}"
  install -d -m 0700 -o ${user} -g ${group} "$oc_state"

  # config
  # If config writes are enabled, keep existing runtime-mutated config to preserve
  # pairing/session metadata written by the gateway.
  if [ "${if configWrites then "1" else "0"}" = "1" ] && [ -e "$oc_state/openclaw.json" ]; then
    chown ${user}:${group} "$oc_state/openclaw.json" || true
    chmod 0600 "$oc_state/openclaw.json" || true
  else
    install -m 0600 -o ${user} -g ${group} ${configTemplate} "$oc_state/openclaw.json"
  fi

  # global dirs
  install -d -m 0700 -o ${user} -g ${group} "$oc_state/credentials"
  install -d -m 0700 -o ${user} -g ${group} "$oc_state/agents"

  # Make skill catalog browsable (NOT auto-enabled)
  install -d -m 0700 -o ${user} -g ${group} "$oc_state/skill-sources"
  ln -sfn ${skillsCatalog} "$oc_state/skill-sources/openclaw-skills"
  chown -h ${user}:${group} "$oc_state/skill-sources/openclaw-skills" || true

  # per-agent scaffolding
  ${pkgs.lib.concatStringsSep "\n" (map (a: ''
    ws="${a.workspace}"
    agentId="${a.id}"

    # agent dir + sessions (auth is per-agent)
    install -d -m 0700 -o ${user} -g ${group} "$oc_state/agents/$agentId/agent"
    install -d -m 0700 -o ${user} -g ${group} "$oc_state/agents/$agentId/sessions"

    # workspace root
    install -d -m 0700 -o ${user} -g ${group} "$ws"
    install -d -m 0700 -o ${user} -g ${group} "$ws/skills"
    install -d -m 0700 -o ${user} -g ${group} "$ws/memory"
    install -d -m 0700 -o ${user} -g ${group} "$ws/skill-sources"

    # link catalog into each workspace too
    ln -sfn ${skillsCatalog} "$ws/skill-sources/openclaw-skills"
    chown -h ${user}:${group} "$ws/skill-sources/openclaw-skills" || true

    # seed templates (only if missing)
    for f in AGENTS.md SOUL.md TOOLS.md USER.md IDENTITY.md BOOT.md BOOTSTRAP.md HEARTBEAT.md MEMORY.md LORE.md PROMPTING-EXAMPLES.md; do
      src="${templatesDir}/$f"
      if [ -e "$src" ] && [ ! -e "$ws/$f" ]; then
        ln -s "$src" "$ws/$f"
      fi
    done

    # main agent uses AGENTS.default.md if present (only if AGENTS.md missing)
    if [ "$agentId" = "main" ] && [ -e "${templatesDir}/AGENTS.default.md" ]; then
      if [ ! -e "$ws/AGENTS.md" ]; then
        ln -s "${templatesDir}/AGENTS.default.md" "$ws/AGENTS.md"
      fi
    fi

    chown -h ${user}:${group} "$ws"/* 2>/dev/null || true
  '') agents)}

  # enable selected skills by linking plugin.skillDir -> workspace/skills/<name>
  ${pkgs.lib.concatStringsSep "\n" (map (l: ''
    for t in ${pkgs.lib.concatStringsSep " " l.targets}; do
      ws=""

      ${pkgs.lib.concatStringsSep "\n" (map (a: ''
        if [ "${a.id}" = "$t" ]; then
          ws="${a.workspace}"
        fi
      '') agents)}

      if [ -n "$ws" ]; then
        ln -sfn ${l.dir} "$ws/skills/${l.name}"
        chown -h ${user}:${group} "$ws/skills/${l.name}" || true
      fi
    done
  '') skillLinks)}
''
