{ pkgs, user, group, stateDir, configTemplate }:

pkgs.writeShellScript "openclaw-init" ''
  set -euo pipefail

  install -d -m 0700 -o ${user} -g ${group} ${stateDir}
  install -d -m 0700 -o ${user} -g ${group} ${stateDir}/.openclaw

  install -m 0600 -o ${user} -g ${group} ${configTemplate} ${stateDir}/.openclaw/openclaw.json

  install -d -m 0700 -o ${user} -g ${group} ${stateDir}/.openclaw/agents/main/sessions
  install -d -m 0700 -o ${user} -g ${group} ${stateDir}/.openclaw/credentials
''
