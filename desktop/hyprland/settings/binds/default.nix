{ lib }:

let
  apps      = import ./apps.nix;
  noctalia  = import ./noctalia.nix;
  focusMove = import ./focus-and-move.nix;
  ws        = import ./workspaces.nix;
  mouse     = import ./mouse.nix;
  media     = import ./media.nix;
in
{
  bind  = apps ++ noctalia ++ focusMove ++ ws ++ mouse.binds;
  bindm = mouse.bindm;
  bindel = media.bindel;
  bindl  = media.bindl;
}
