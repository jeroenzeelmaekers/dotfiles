{ ... }:
{
  services.aerospace.settings = {
    "after-startup-command" = [
      "workspace misc_1"
      "layout v_tiles"
      "workspace misc_2"
      "layout v_tiles"
      "workspace web"
    ];

    "workspace-to-monitor-force-assignment" = {
      misc_1 = 2;
      misc_2 = 2;
    };

    "gaps" = {
      inner.horizontal = 10;
      inner.vertical = 10;
      outer.left = 14;
      outer.bottom = 14;
      outer.top = 6;
      outer.right = 14;
    };

    mode.main.binding = {
      "alt-1" = "workspace web";
      "alt-2" = "workspace term";
      "alt-3" = "workspace space_0";
      "alt-4" = "workspace space_1";
      "alt-5" = "workspace space_2";
      "alt-6" = "workspace space_3";
      "alt-7" = "workspace space_4";
      "alt-8" = "workspace misc_1";
      "alt-9" = "workspace misc_2";
      "alt-shift-1" = [ "move-node-to-workspace web" "workspace web" ];
      "alt-shift-2" = [ "move-node-to-workspace term" "workspace term" ];
      "alt-shift-3" = [ "move-node-to-workspace space_0" "workspace space_0" ];
      "alt-shift-4" = [ "move-node-to-workspace space_1" "workspace space_1" ];
      "alt-shift-5" = [ "move-node-to-workspace space_2" "workspace space_2" ];
      "alt-shift-6" = [ "move-node-to-workspace space_3" "workspace space_3" ];
      "alt-shift-7" = [ "move-node-to-workspace space_4" "workspace space_4" ];
      "alt-shift-8" = [ "move-node-to-workspace misc_1" "workspace misc_1" ];
      "alt-shift-9" = [ "move-node-to-workspace misc_2" "workspace misc_2" ];
    };

    "on-window-detected" = [
      {
        "if".app-name-regex-substring = "simulator";
        run = "layout tiling";
      }
      {
        "if".app-name-regex-substring = "finder";
        run = "layout floating";
      }
      {
        "if".app-id = "com.apple.Safari";
        run = [ "move-node-to-workspace web" "focus-back-and-forth" ];
      }
      {
        "if".app-id = "net.imput.helium";
        run = [ "move-node-to-workspace web" "focus-back-and-forth" ];
      }
      {
        "if".app-name-regex-substring = "rex beta";
        run = [ "move-node-to-workspace term" "focus-back-and-forth" ];
      }
      {
        "if".app-name-regex-substring = "parallels";
        run = "layout tiling";
      }
    ];
  };
}
