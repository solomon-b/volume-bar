final: prev: {
  volume-bar = let watcher = final.callPackage ./derivation.nix { };
  in final.writeShellScriptBin "volume-bar" ''
    ${watcher}/bin/pulse-volume-watcher.py | ${final.xob}/bin/xob -c ${
      ./xob.config
    } -s default
  '';
}
