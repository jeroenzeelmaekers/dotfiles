{ ... }:
{
  services.aerospace = {
    enable = true;
    settings = {
      "config-version" = 2;
      start-at-login = false;
      "default-root-container-layout" = "tiles";

      "on-window-detected" = [
        {
          "if".app-id = "com.apple.dt.Devices";
          run = "layout tiling";
        }
      ];

      mode.main.binding = {
        "alt-h" = "focus left";
        "alt-j" = "focus down";
        "alt-k" = "focus up";
        "alt-l" = "focus right";
        "alt-shift-h" = "move left";
        "alt-shift-j" = "move down";
        "alt-shift-k" = "move up";
        "alt-shift-l" = "move right";
        "alt-shift-f" = "layout floating tiling";
        "alt-f" = "fullscreen";
      };
    };
  };
}
