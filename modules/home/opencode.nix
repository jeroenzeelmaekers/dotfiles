{ config, ... }:
let
  dotfilesDirectory = "${config.home.homeDirectory}/github/jeroenzeelmaekers/dotfiles";
in
{
  # OpenCode and Herdr both update files in this directory. Keep it outside
  # the read-only Nix store and preserve relative imports between plugins.
  xdg.configFile."opencode" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDirectory}/config/opencode";
    force = true;
  };
}
