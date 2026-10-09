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
      dark = "melange-dark";
      light = "melange-light";
    };
    flavors = {
      melange-dark = ../../assets/yazi/flavors/melange-dark.yazi;
      melange-light = ../../assets/yazi/flavors/melange-light.yazi;
    };
  };
}
