{
  description = "Electron-based Notion Calendar client";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      version = "1.0.4";
    in
    {
      pkgs.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "notion-calendar-electron";
        version = "${version}";

        src = pkgs.fetchFromGitHub {
          owner = "czlabinger";
          repo = "notion-calendar-electron";
          rev = "v${version}";
          sha256 = "sha256-1jd1dphj6h8sm14c31rbml73bxrcf9gfgg0r0wa27jlmgp3mhkl7"; # Replace with real sha256
        };

        buildInputs = [ pkgs.nodejs pkgs.npm pkgs.git ];

        nativeBuildInputs = [ pkgs.electron ];

        unpackPhase = ''
          mkdir -p $sourceRoot
          tar -xf $src --strip-components=1
        '';

        installPhase = ''
          npm install --no-fund --no-audit
          npm run build
          
          mkdir -p $out/usr/share/notion-calendar-electron
          mkdir -p $out/usr/bin
          mkdir -p $out/usr/share/applications

          cp -r dist/linux-unpacked/* $out/usr/share/notion-calendar-electron
          cp -P ./notion-calendar-electron $out/usr/bin/
          cp ./icon.png $out/usr/share/notion-calendar-electron/
          cp ./notion-calendar-electron.desktop $out/usr/share/applications/
        '';

        meta = with pkgs.lib; {
          description = "A Electron-based Notion Calendar client";
          homepage = "https://www.notion.so/product/calendar";
          license = licenses.mit;
          platforms = platforms.linux;
        };
      };

      # Explicitly set the default package
      defaultPackage.${system} = pkgs.${system}.default;
    });
}
