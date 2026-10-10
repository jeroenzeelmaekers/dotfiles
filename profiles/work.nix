{ ... }:
{
  programs.git.settings.user = {
    name = "Jeroen Zeelmaekers";
    email = "jeroen.zeelmaekers@ae.be";
  };

  home.file."Pictures/Wallpapers/wallpaper.jpg".source =
    ../assets/wallpapers/wallpaper.jpg;
}
