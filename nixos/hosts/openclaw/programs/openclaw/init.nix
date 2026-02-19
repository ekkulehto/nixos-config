{ pkgs, user, group, stateDir, configTemplate }:

pkgs.writeShellScript "openclaw-init" ''
  set -euo pipefail

  install -d -m 0700 -o ${user} -g ${group} ${stateDir}
  install -m 0600 -o ${user} -g ${group} ${configTemplate} ${stateDir}/openclaw.json
''
