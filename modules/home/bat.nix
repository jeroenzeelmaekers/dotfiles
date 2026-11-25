{ ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme-dark = "Catppuccin Mocha";
      theme-light = "Catppuccin Latte";
      style = "numbers,changes,header";
      italic-text = "always";
    };
    themes = {
      "Catppuccin Mocha" = {
        src = ../../assets/bat/themes;
        file = "Catppuccin Mocha.tmTheme";
      };
      "Catppuccin Latte" = {
        src = ../../assets/bat/themes;
        file = "Catppuccin Latte.tmTheme";
      };
    };
  };
}
