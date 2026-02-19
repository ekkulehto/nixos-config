{ stateDir }:

{
  NoNewPrivileges = true;
  PrivateTmp = true;

  ProtectSystem = "strict";
  ProtectHome = true;

  ProtectKernelTunables = true;
  ProtectKernelModules = true;
  ProtectControlGroups = true;

  RestrictSUIDSGID = true;
  LockPersonality = true;
  MemoryDenyWriteExecute = true;

  ReadWritePaths = [ stateDir ];
  UMask = "0077";
}
