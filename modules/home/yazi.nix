{ ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings.opener.edit = [
      {
        run = "nvim %s";
        block = true;
        "for" = "unix";
      }
    ];
    theme.flavor = {
      dark = "catppuccin-mocha";
      light = "catppuccin-latte";
    };
    flavors = {
      catppuccin-mocha = ../../assets/yazi/flavors/catppuccin-mocha.yazi;
      catppuccin-latte = ../../assets/yazi/flavors/catppuccin-latte.yazi;
    };
  };
}
