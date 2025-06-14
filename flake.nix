{
  description = "Prolog experiments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    swipl-nix.url = "github:matko/swipl-nix";
  };

  outputs = { self, nixpkgs, flake-utils, swipl-nix }:
    flake-utils.lib.eachSystem [ "x86_64-darwin" "x86_64-linux" "i686-linux" ] (system:
      let pkgs = import nixpkgs
        { inherit system;
          overlays = [ swipl-nix.overlays.default ]; };
      in {
        defaultPackage = pkgs.mkShell {
          name = "logpro";
          buildInputs = [ pkgs.swipl-nix."9_2_3" ];
          shellHook = "echo 'logpro...'";
        };
      }
    );
}
