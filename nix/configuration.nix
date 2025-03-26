{ pkgs, ... }:
let
  aerospaceWindowGap = 15;
  meh = "ctrl-alt-shift";
  hyper = "${meh}-cmd";
in
{
  system.stateVersion = 5;

  nix.gc.automatic = true;
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.systemPackages = [
    pkgs.gimp
    pkgs.ice-bar
    pkgs.iina
    pkgs.karabiner-elements
    pkgs.keycastr
    pkgs.mas
    pkgs.qmk
    pkgs.vscodium
  ];

  homebrew = {
    enable = true;
    casks = [
      "alcove"
      "discord"
      "dockdoor"
      "ghostty"
      "hammerspoon"
      "leader-key"
      "logitune"
      "nordvpn"
      "raycast"
      "rocket"
      "sanesidebuttons"
      "sf-symbols"
      "whisky"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  programs.zsh.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  services.aerospace = {
    enable = true;
    settings = {
      accordion-padding = aerospaceWindowGap;
      automatically-unhide-macos-hidden-apps = true;
      on-window-detected = [
        {
          "if" = {
            window-title-regex-substring = "Picture.*in.*Picture";
          };
          run = "layout floating";
        }
        {
          "if" = {
            window-title-regex-substring = "Hammerspoon Console";
          };
          run = "layout floating";
        }
        {
          "if" = {
            app-id = "com.apple.AppStore";
          };
          run = "layout floating";
        }
        {
          "if" = {
            app-id = "com.apple.FaceTime";
          };
          run = "layout floating";
        }
        {
          "if" = {
            app-id = "com.apple.Notes";
          };
          run = "layout floating";
        }
        {
          "if" = {
            app-id = "com.mitchellh.ghostty";
          };
          run = "move-node-to-workspace 1";
        }
        {
          "if" = {
            app-id = "com.hnc.Discord";
          };
          run = "move-node-to-workspace 2";
        }
        {
          "if" = {
            app-id = "com.apple.MobileSMS";
          };
          run = "move-node-to-workspace 2";
        }
      ];
      gaps = {
        inner = {
          horizontal = aerospaceWindowGap;
          vertical = aerospaceWindowGap;
        };
        outer = {
          left = aerospaceWindowGap;
          bottom = aerospaceWindowGap;
          top = aerospaceWindowGap;
          right = aerospaceWindowGap;
        };
      };
      mode = {
        main.binding = {
          "${meh}-slash" = "layout tiles horizontal vertical";
          "${meh}-comma" = "layout accordion vertical horizontal";

          "${meh}-f" = "fullscreen";
          "${hyper}-f" = "layout floating tiling";
          "${hyper}-r" = "flatten-workspace-tree";

          "${meh}-h" = "focus left";
          "${meh}-j" = "focus down";
          "${meh}-k" = "focus up";
          "${meh}-l" = "focus right";

          "${hyper}-h" = "move left";
          "${hyper}-j" = "move down";
          "${hyper}-k" = "move up";
          "${hyper}-l" = "move right";

          "${meh}-equal" = "balance-sizes";
          "${hyper}-minus" = "resize smart -50";
          "${hyper}-equal" = "resize smart +50";

          ctrl-1 = "workspace 1";
          ctrl-2 = "workspace 2";
          ctrl-3 = "workspace 3";

          "${meh}-1" = "move-node-to-workspace 1";
          "${meh}-2" = "move-node-to-workspace 2";
          "${meh}-3" = "move-node-to-workspace 3";

          "${hyper}-1" = "move-node-to-monitor 1";
          "${hyper}-2" = "move-node-to-monitor 2";
          "${hyper}-3" = "move-node-to-monitor 3";

          "${meh}-tab" = "focus-back-and-forth";
          "${hyper}-tab" = "workspace-back-and-forth";

          "${meh}-semicolon" = "mode service";
        };
        service.binding = {
          esc = [
            "reload-config"
            "mode main"
          ];

          h = [
            "join-with left"
            "mode main"
          ];
          j = [
            "join-with down"
            "mode main"
          ];
          k = [
            "join-with up"
            "mode main"
          ];
          l = [
            "join-with right"
            "mode main"
          ];

          "${meh}-h" = [
            "join-with left"
            "layout v_accordion"
            "mode main"
          ];
          "${meh}-j" = [
            "join-with down"
            "layout h_accordion"
            "mode main"
          ];
          "${meh}-k" = [
            "join-with up"
            "layout h_accordion"
            "mode main"
          ];
          "${meh}-l" = [
            "join-with right"
            "layout v_accordion"
            "mode main"
          ];
        };
      };
    };
  };

  services.jankyborders = {
    enable = true;
    active_color = "0xFFA6E3A1";
    width = 8.0;
    hidpi = true;
    inactive_color = "";
  };

  system.defaults = {
    NSGlobalDomain = {
      _HIHideMenuBar = false;
      AppleEnableMouseSwipeNavigateWithScrolls = true;
      AppleInterfaceStyle = "Dark";
      AppleShowScrollBars = "WhenScrolling";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    };

    dock = {
      appswitcher-all-displays = true;
      autohide = true;
      magnification = true;
      persistent-apps = [
        "/System/Applications/Launchpad.app"
        "/System/Applications/Notes.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Music.app"
        "/Applications/Ghostty.app"
        "/System/Applications/Passwords.app"
      ];
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    loginwindow.GuestEnabled = false;

    menuExtraClock = {
      ShowAMPM = true;
      ShowDate = 1;
      ShowDayOfWeek = false;
      ShowSeconds = true;
    };

    spaces.spans-displays = false;

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.mononoki
  ];
}
