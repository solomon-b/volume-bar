{
  description = "Xob Volume Bar";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = let watcher = pkgs.callPackage ./derivation.nix { };
        in pkgs.writeShellScriptBin "volume-bar" ''
          ${watcher}/bin/pulse-volume-watcher.py | ${pkgs.xob}/bin/xob -c ${
            ./xob.config
          } -s default
        '';

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.python3
            pkgs.python3Packages.pulsectl
            pkgs.xob
            pkgs.nixfmt
          ];
        };
      }) // {
        overlays.default = import ./overlay.nix;
      };
}
