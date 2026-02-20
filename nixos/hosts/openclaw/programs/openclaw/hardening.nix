{ stateDir }:
{
  NoNewPrivileges = true;
  RemoveIPC = true;

  ProtectSystem = "strict";
  ProtectHome = true;
  ProtectProc = "invisible";
  ProcSubset = "pid";

  PrivateTmp = true;
  PrivateDevices = true;
  PrivateUsers = true;

  ReadWritePaths = [ stateDir ];
  UMask = "0077";

  ProtectKernelTunables = true;
  ProtectKernelModules = true;
  ProtectKernelLogs = true;
  ProtectControlGroups = true;
  ProtectClock = true;
  ProtectHostname = true;

  LockPersonality = true;
  RestrictRealtime = true;
  RestrictSUIDSGID = true;
  RestrictNamespaces = true;

  CapabilityBoundingSet = "";
  AmbientCapabilities = "";

  MemoryDenyWriteExecute = true;

  SystemCallArchitectures = "native";

  SystemCallFilter = [
    "~@clock"
    "~@cpu-emulation"
    "~@debug"
    "~@module"
    "~@mount"
    "~@obsolete"
    "~@privileged"
    "~@raw-io"
    "~@reboot"
    "~@resources"
    "~@swap"
    
    "@chown"
  ];

  RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" "AF_NETLINK" ];

  # IPAddressDeny = [
  #   "10.0.0.0/8"
  #   "172.16.0.0/12"
  #   "192.168.0.0/16"
  #   "169.254.0.0/16"
  # ];
}

