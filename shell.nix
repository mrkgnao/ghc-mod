{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc821" }:
let nixpkgs_source = "/home/mrkgnao/nixpkgs";
  nixpkgs' = (import nixpkgs_source){};
in with nixpkgs'.pkgs;
let hp = haskell.packages.${compiler}.override{
    overrides = self: super: {
      cabal-helper = self.callPackage ./cabal-helper.nix {};
      ghc-mod = self.callPackage ./ghc-mod.nix {};
      };};
     getHaskellDeps = ps: path:
        let f = import path;
            gatherDeps = { buildDepends ? [], libraryHaskellDepends ? [], executableHaskellDepends ? [], libraryToolDepends ? [], executableToolDepends ? [], ...}:
               buildDepends ++ libraryHaskellDepends ++ executableHaskellDepends ++ libraryToolDepends ++ executableToolDepends;
            x = f (builtins.intersectAttrs (builtins.functionArgs f) ps // {stdenv = stdenv; mkDerivation = gatherDeps;});
        in x;
ghc = hp.ghcWithPackages (ps: with ps; stdenv.lib.lists.subtractLists
[ghc-mod]
([ cabal-install 
cabal-helper
  ]  ++ getHaskellDeps ps ./ghc-mod.nix));
in
pkgs.stdenv.mkDerivation {
  name = "my-haskell-env-0";
  buildInputs = [ ghc ];
  shellHook = ''
 export LANG=en_US.UTF-8
 eval $(egrep ^export ${ghc}/bin/ghc)
'';
}
