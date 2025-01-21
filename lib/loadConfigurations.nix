scoped: importScoped: {
  inputs,
  lib,
  pkgs,
  src,
}: let
  loadSystems = inputs.haumea.lib.load {
    inherit src;
    loader = inputs.haumea.lib.loaders.verbatim;
  };
  systemNames = builtins.attrNames loadSystems;
in
  lib.attrsets.genAttrs systemNames
  (systemName: scoped:
    import "${src}/${systemName}/${systemName}.nix"
    {inherit inputs lib pkgs;})
