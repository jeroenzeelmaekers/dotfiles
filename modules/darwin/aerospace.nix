{ ... }:
{
  services.aerospace = {
    enable = true;
    settings = {
      "config-version" = 2;
      start-at-login = false;
      "default-root-container-layout" = "tiles";

      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.left = 14;
        outer.bottom = 16;
        outer.top = 6;
        outer.right = 14;
      };

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
