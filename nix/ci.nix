# In CI, pin nixpkgs for a reproducible build.
#
let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz") {};
in
import ../default.nix { inherit pkgs; }

