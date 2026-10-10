{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        autoFetch = false;
        overrideGpg = true;
      };
      gui = {
        showBottomLine = true;
        showRandomTip = false;
      };
    };
  };
}
