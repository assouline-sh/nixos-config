{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, caelestia-shell, ... }: let
    system = "x86_64-linux";
    patchedCaelestiaShell = caelestia-shell.packages.${system}.with-cli.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        cp ${./patches/status-icons.qml} $out/share/caelestia-shell/modules/bar/components/StatusIcons.qml
        cp ${./patches/battery-popout.qml} $out/share/caelestia-shell/modules/bar/popouts/Battery.qml
        cp ${./patches/session-content.qml} $out/share/caelestia-shell/modules/session/Content.qml
        cp ${./patches/utilities-content.qml} $out/share/caelestia-shell/modules/utilities/Content.qml
        cp ${./patches/launcher-appitem.qml} $out/share/caelestia-shell/modules/launcher/items/AppItem.qml
        cp ${./patches/launcher-applist.qml} $out/share/caelestia-shell/modules/launcher/AppList.qml
        cp ${./patches/launcher-contentlist.qml} $out/share/caelestia-shell/modules/launcher/ContentList.qml
        cp ${./patches/toggles.qml} $out/share/caelestia-shell/modules/utilities/cards/Toggles.qml
        cp ${./patches/lock-surface.qml} $out/share/caelestia-shell/modules/lock/LockSurface.qml
      '';
    });
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kud = { ... }: {
            imports = [ ./home.nix ];
            programs.caelestia.package = patchedCaelestiaShell;
          };
          home-manager.sharedModules = [
            caelestia-shell.homeManagerModules.default
          ];
        }
      ];
    };
  };
}
