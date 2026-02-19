let
  workstation_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH41X3v4Fmn7sU1o0Bs+qb/CEoi2CBoiPGkjyL7L77IR root@nixos";
  openclaw_host    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcjVQaWzz1GgPNssqjIOTnYLu+UA/VN17Lem6UavoYP root@openclaw";
  ekku_user        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKoF3DTqAs3ZGqUljH/R0RwFm14JBJD7EgBvmvCSqyn ekkulehto@proton.me";
in
{
  "secrets/openclaw/telegram-bot-token.age".publicKeys = [ openclaw_host workstation_host ekku_user ];
  "secrets/openclaw/openclaw.env.age".publicKeys       = [ openclaw_host workstation_host ekku_user ];
}

