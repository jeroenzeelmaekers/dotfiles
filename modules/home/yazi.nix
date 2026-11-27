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
      dark = "rose-pine";
      light = "rose-pine-dawn";
    };
    flavors = {
      rose-pine = ../../assets/yazi/flavors/rose-pine.yazi;
      rose-pine-dawn = ../../assets/yazi/flavors/rose-pine-dawn.yazi;
    };
  };
}
