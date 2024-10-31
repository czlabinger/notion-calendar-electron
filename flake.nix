{
  description = "Electron-based Notion Calendar client";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        node-modules = pkgs.mkYarnPackage {
          name = "node-modules";
          src = ./.;
        };
        package = pkgs.stdenv.mkDerivation {
          name = "notion-calendar-electron";
          src = ./.;
          buildInputs = [pkgs.yarn node-modules];

          buildPhase = ''
            ${pkgs.yarn}/bin/yarn build
          '';

          installPhase =  ''
          mkdir $out

          mkdir -p $out/usr/share/notion-calendar-electron
          mkdir -p $out/usr/bin
          mkdir -p $out/usr/share/applications

          cp -r ./dist/linux-unpacked/* $out/usr/share/notion-calendar-electron
          cp -P ./notion-calendar-electron $out/usr/bin/
          cp ./icon.png $out/usr/share/notion-calendar-electron/
          cp ./notion-calendar-electron.desktop $out/usr/share/applications/
          '';

        };
      in
        {
          packages = {
            node-modules = node-modules;
            default = package;
          };
        }
    );
}
