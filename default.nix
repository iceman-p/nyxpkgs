{ system ? builtins.currentSystem }:
let
  pkgs = import <nixpkgs> { inherit system; };
in rec {
  derpibooru-downloader = pkgs.callPackage ./pkgs/derpibooru-downloader {
    inherit pkgs;
  };
}
