{ lib, ... }:
let
  nvimConfig = builtins.path {
    path = ../../config/nvim;
    name = "nvim-config";
    filter = path: type: builtins.baseNameOf path != "lazy-lock.json";
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    sideloadInitLua = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile.nvim = {
    source = nvimConfig;
    recursive = true;
  };

  home.activation.nvimLazyLock = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    lockfile="$HOME/.config/nvim/lazy-lock.json"
    if [[ ! -e "$lockfile" ]]; then
      run install -m 0644 ${../../config/nvim/lazy-lock.json} "$lockfile"
    fi
  '';
}
