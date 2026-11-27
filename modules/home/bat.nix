{ ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme-dark = "Rose Pine";
      theme-light = "Rose Pine Dawn";
      style = "numbers,changes,header";
      italic-text = "always";
    };
    themes = {
      "Rose Pine" = {
        src = ../../assets/bat/themes;
        file = "Rose Pine.tmTheme";
      };
      "Rose Pine Dawn" = {
        src = ../../assets/bat/themes;
        file = "Rose Pine Dawn.tmTheme";
      };
    };
  };
}
