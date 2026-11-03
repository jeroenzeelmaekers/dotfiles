{ ... }:
{
  services.aerospace.settings = {
    "after-startup-command" = [
      "workspace misc_2"
      "layout v_tiles"
      "workspace misc_3"
      "layout v_tiles"
      "workspace web"
    ];

    "workspace-to-monitor-force-assignment" = {
      misc_2 = 2;
      misc_3 = 2;
    };

    mode.main.binding = {
      "alt-1" = "workspace web";
      "alt-2" = "workspace term";
      "alt-3" = "workspace notes";
      "alt-4" = "workspace teams";
      "alt-5" = "workspace mail";
      "alt-6" = "workspace music";
      "alt-7" = "workspace misc_1";
      "alt-8" = "workspace misc_2";
      "alt-9" = "workspace misc_3";
      "alt-shift-1" = [ "move-node-to-workspace web" "workspace web" ];
      "alt-shift-2" = [ "move-node-to-workspace term" "workspace term" ];
      "alt-shift-3" = [ "move-node-to-workspace notes" "workspace notes" ];
      "alt-shift-4" = [ "move-node-to-workspace teams" "workspace teams" ];
      "alt-shift-5" = [ "move-node-to-workspace mail" "workspace mail" ];
      "alt-shift-6" = [ "move-node-to-workspace music" "workspace music" ];
      "alt-shift-7" = [ "move-node-to-workspace misc_1" "workspace misc_1" ];
      "alt-shift-8" = [ "move-node-to-workspace misc_2" "workspace misc_2" ];
      "alt-shift-9" = [ "move-node-to-workspace misc_3" "workspace misc_3" ];
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
        "if".app-id = "com.google.Chrome";
        run = [ "move-node-to-workspace web" "focus-back-and-forth" ];
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
        "if".app-name-regex-substring = "teams";
        run = [ "move-node-to-workspace teams" "focus-back-and-forth" ];
      }
      {
        "if".app-name-regex-substring = "mail";
        run = [ "move-node-to-workspace mail" "focus-back-and-forth" ];
      }
      {
        "if".app-name-regex-substring = "parallels";
        run = "layout tiling";
      }
    ];
  };
}
