let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = 
          haskellPackagesNew: 
          haskellPackagesOld: 
          rec {
            ghc-mod =
              haskellPackagesNew.callPackage ./default.nix { };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in
  { ghc-mod = pkgs.haskellPackages.ghc-mod;
  }
