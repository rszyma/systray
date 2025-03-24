{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem
    (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        runtime-deps = [ pkgs.libayatana-appindicator pkgs.gtk3 ];
        build-deps = [ pkgs.pkg-config ];
      in
       {
        devShells.default = pkgs.mkShell
          {
            packages =
              build-deps
              ++ runtime-deps
              ++ [
                pkgs.webkitgtk_4_0 # just for webview_example
              ];
          };
      }
    );
}
