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
          cmdLineToolsVersion = "latest";

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

        fixedAndroidSDK = pkgs.runCommand "fixed-android-sdk" { } ''
          mkdir -p $out

          # Symlink everything from the original SDK
          ln -s ${androidSDK.androidsdk}/libexec/android-sdk/* $out/

          # Remove the read-only cmdline-tools symlink to rewrite it properly
          rm $out/cmdline-tools
          mkdir -p $out/cmdline-tools

          # Link the versioned folder (21.0) directly as 'latest' inside the store directory
          ln -s ${androidSDK.androidsdk}/libexec/android-sdk/cmdline-tools/21.0 $out/cmdline-tools/latest
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.flutter338
            pkgs.jdk17
            androidSDK.androidsdk
          ];

          shellHook = ''
            # export ANDROID_HOME="${androidSDK.androidsdk}/libexec/android-sdk"
            export ANDROID_HOME="${fixedAndroidSDK}"
            export ANDROID_SDK_ROOT="$ANDROID_HOME"
            export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=$ANDROID_HOME/build-tools/36.0.0/aapt2" 

            export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"

            flutter config --android-sdk "$ANDROID_HOME" > /dev/null

            echo "Welcome to flutter Shell"
          '';
        };
      }
    );
}
