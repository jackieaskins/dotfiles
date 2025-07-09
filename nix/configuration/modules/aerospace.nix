{ ... }:
let
  aerospaceWindowGap = 15;
  meh = "ctrl-alt-shift";
  hyper = "${meh}-cmd";

  directionKeys = [
    {
      key = "h";
      direction = "left";
      layout = "v";
    }
    {
      key = "j";
      direction = "down";
      layout = "h";
    }
    {
      key = "k";
      direction = "up";
      layout = "h";
    }
    {
      key = "l";
      direction = "right";
      layout = "v";
    }
  ];
in
{
  services.aerospace = {
    enable = true;

    settings = {
      accordion-padding = aerospaceWindowGap;
      automatically-unhide-macos-hidden-apps = true;

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
            app-id = "com.apple.finder";
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
            app-id = "com.apple.Music";
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
}
