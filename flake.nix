{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.default = import ./shell.nix { inherit pkgs; };
    });
}
