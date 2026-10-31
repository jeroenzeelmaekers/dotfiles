{ config, ... }:
let
  dotfilesDirectory = "${config.home.homeDirectory}/github/jeroenzeelmaekers/dotfiles";
in
{
  # Keep OpenCode's files outside the read-only Nix store so integrations can
  # update them and relative plugin imports continue to work.
  xdg.configFile."opencode" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDirectory}/config/opencode";
    force = true;
  };
}
