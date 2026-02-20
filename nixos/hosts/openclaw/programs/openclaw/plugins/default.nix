{ pkgs, inputs }:

let
  entries = builtins.readDir ./.;

  pluginNames =
    builtins.filter
      (n: entries.${n} == "directory" && n != "." && n != "..")
      (builtins.attrNames entries);

  plugins = map (name: import (./. + "/${name}/default.nix") { inherit pkgs inputs; }) pluginNames;

  # plugin can return either `package` or `packages`
  packages = builtins.concatLists (map (p:
    (p.packages or []) ++ (if p ? package then [ p.package ] else [])
  ) plugins);

  # each plugin returns { name, skillDir, targets = [ "research" ... ] }
  skillLinks = map (p: {
    name = p.name;
    dir = p.skillDir;
    targets = p.targets or [ "main" ];
  }) plugins;

in {
  inherit plugins packages skillLinks;
}
