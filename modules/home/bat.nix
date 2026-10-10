{ ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme-dark = "Melange Dark";
      theme-light = "Melange Light";
      style = "numbers,changes,header";
      italic-text = "always";
    };
    themes = {
      "Melange Dark" = {
        src = ../../assets/bat/themes;
        file = "Melange Dark.tmTheme";
      };
      "Melange Light" = {
        src = ../../assets/bat/themes;
        file = "Melange Light.tmTheme";
      };
    };
  };
}
