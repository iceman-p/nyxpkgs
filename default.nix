{ system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> { inherit system; } }:

rec {
  derpibooru-downloader = pkgs.callPackage ./pkgs/derpibooru-downloader {
    inherit pkgs;
  };

  basc-archiver = pkgs.callPackage ./pkgs/basc-archiver {
    inherit pkgs;
  };
}
