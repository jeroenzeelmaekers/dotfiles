{ ... }:
{
  programs.git.settings.user = {
    name = "Jeroen Zeelmaekers";
    email = "mail@jeroenzeelmaekers.com";
  };

  home.file."Pictures/Wallpapers/wallpaper.jpg".source =
    ../assets/wallpapers/wallpaper.jpg;
}
