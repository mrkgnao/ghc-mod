{ mkDerivation, base, binary, bytestring, Cabal, cabal-helper
, containers, deepseq, directory, djinn-ghc, doctest, extra
, fclabels, filepath, ghc, ghc-boot, ghc-paths, ghc-syb-utils
, haskell-src-exts, hlint, hspec, monad-control, monad-journal, mtl
, old-time, optparse-applicative, pipes, process, safe, semigroups
, split, stdenv, syb, template-haskell, temporary, text, time
, transformers, transformers-base
}:
mkDerivation {
  pname = "ghc-mod";
  version = "5.8.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  setupHaskellDepends = [
    base Cabal containers directory filepath process template-haskell
    transformers
  ];
  libraryHaskellDepends = [
    base binary bytestring cabal-helper containers deepseq directory
    djinn-ghc extra fclabels filepath ghc ghc-boot ghc-paths
    ghc-syb-utils haskell-src-exts hlint monad-control monad-journal
    mtl old-time optparse-applicative pipes process safe semigroups
    split syb template-haskell temporary text time transformers
    transformers-base
  ];
  executableHaskellDepends = [
    base binary deepseq directory fclabels filepath ghc monad-control
    mtl old-time optparse-applicative process semigroups split time
  ];
  testHaskellDepends = [
    base cabal-helper containers directory doctest fclabels filepath
    ghc ghc-boot hspec monad-journal mtl process split temporary
    transformers
  ];
  homepage = "https://github.com/DanielG/ghc-mod";
  description = "Happy Haskell Hacking";
  license = stdenv.lib.licenses.agpl3;
}
