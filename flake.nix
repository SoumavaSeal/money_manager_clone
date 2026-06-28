{
  description = "Flutter 3.38.x";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
        androidSDK = pkgs.androidenv.composeAndroidPackages {
          platformVersions = [
            "35"
            "36"
          ];
          buildToolsVersions = [
            "35.0.0"
            "36.0.0"
          ];
          includeEmulator = true;
          emulatorVersion = "36.3.10"; # Matches your list
          platformToolsVersion = "36.0.2";

          includeNDK = true;
          ndkVersions = [ "28.2.13676358" ]; # Side-by-side NDK

          includeSystemImages = true;
          systemImageTypes = [ "google_apis_playstore" ];
          abiVersions = [ "x86_64" ];

          cmakeVersions = [ "3.22.1" ];

          extraLicenses = [
            "android-sdk-preview-license"
            "google-gdk-license"
            "intel-android-extra-license"
            "intel-android-sysimage-license"
          ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.flutter338
            pkgs.jdk17
            androidSDK.androidsdk
          ];

          shellHook = ''
            echo "🛡️ Flutter Dev Environment Loaded!"
            flutter --version
            export ANDROID_HOME="${androidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_SDK_ROOT="$ANDROID_HOME"
            export PATH=$PATH:${androidSDK.androidsdk}/libexec/android-sdk/cmdline-tools/latest/bin
          '';
        };
      }
    );
}
