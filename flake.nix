{
  description = "Electron application flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "notion-caledar-electron";
          src = ./.;
          version = "v1.0.4";

          buildInputs = [ pkgs.electron ];

          installPhase = ''
            mkdir -p $out

            cp -r $src/* $out/

            mkdir -p $out/bin
            mkdir -p $out/share/notion-calendar-electron
            mkdir -p $out/share/applications

            # Create wrapper script
            cat > $out/bin/notion-calendar-electron <<EOF
            #!${pkgs.stdenv.shell}
            exec ${pkgs.electron}/bin/electron $out
            EOF

            cp $src/icon.png $out/share/notion-calendar-electron/
            cp $src/notion-calendar-electron.desktop $out/share/applications/

            chmod +x $out/bin/notion-calendar-electron
          '';
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/notion-calendar-electron";
        };
      }
    );
}
