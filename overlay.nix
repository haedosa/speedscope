self: final: prev: with final; let

  haskellPackages = prev.haskellPackages.override (old: {
    overrides = lib.composeManyExtensions [
      (old.overrides or (_: _: {}))
      (hfinal: hprev: with haskell.lib; {
        hs-speedscope = doJailbreak (markUnbroken hprev.hs-speedscope);
      })
    ];
  });

in
{
  speedscope = writeShellScriptBin "speedscope" ''
    ${haskellPackages.hs-speedscope}/bin/hs-speedscope $1
    ${self.packages.${final.system}.speedscope}/bin/speedscope $1.json &> /dev/null
  '';
}
