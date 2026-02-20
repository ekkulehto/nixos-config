{ stateDir }:

{
  NoNewPrivileges = true;
  PrivateTmp = true;
  PrivateDevices = true;

  ProtectSystem = "strict";
  ProtectHome = true;

  ProtectKernelTunables = true;
  ProtectKernelModules = true;
  ProtectControlGroups = true;
  ProtectKernelLogs = true;
  ProtectClock = true;
  ProtectHostname = true;

  RestrictSUIDSGID = true;
  LockPersonality = true;
  RestrictRealtime = true;
  RestrictNamespaces = true;

  MemoryDenyWriteExecute = false;

  ReadWritePaths = [ stateDir ];
  UMask = "0077";
}
