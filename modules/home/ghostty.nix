{ ... }:
{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "dark:Melange Dark, light:Melange Light";
      font-family = "Berkeley Mono";
      font-style = "SemiBold";
      font-style-italic = "SemiBold Italic";
      font-style-bold = "Bold";
      font-style-bold-italic = "Bold Italic";
      font-size = 15;
      window-padding-balance = true;
      window-padding-x = 10;
      window-padding-y = 10;
      macos-titlebar-style = "hidden";
      mouse-hide-while-typing = true;
    };
  };
}
