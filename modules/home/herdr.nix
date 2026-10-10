{ pkgs, ... }:
let
  herdrPlugins = [
    {
      id = "vim-herdr-navigation";
      source = "paulbkim-dev/vim-herdr-navigation";
    }
  ];

  restoreHerdrPlugins = pkgs.writeShellApplication {
    name = "herdr-restore-plugins";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      plugins_json='${builtins.toJSON herdrPlugins}'

      if ! command -v herdr >/dev/null 2>&1; then
        echo "herdr-restore-plugins: herdr is not on PATH" >&2
        exit 1
      fi

      installed_json="$(herdr plugin list --json)"
      plugin_rows="$(jq -ce '
        (.result.plugins // .plugins)
        | if type == "array" then . else error("plugin list did not contain a plugins array") end
      ' <<<"$installed_json")"

      while IFS= read -r plugin; do
        id="$(jq -r '.id' <<<"$plugin")"
        source="$(jq -r '.source' <<<"$plugin")"
        existing="$(jq -c --arg id "$id" '[.[] | select(.plugin_id == $id)][0] // empty' <<<"$plugin_rows")"

        if [[ -z "$existing" ]]; then
          echo "Installing latest $id from $source"
          herdr plugin install "$source" --yes
          continue
        fi

        source_kind="$(jq -r '.source.kind // "unknown"' <<<"$existing")"
        if [[ "$source_kind" != "github" ]]; then
          echo "herdr-restore-plugins: $id is installed from a non-GitHub source; unlink or uninstall it before restoring" >&2
          exit 1
        fi

        installed_source="$(jq -r '[.source.owner // "", .source.repo // ""] | join("/")' <<<"$existing")"
        if [[ "$installed_source" != "$source" ]]; then
          echo "herdr-restore-plugins: $id is installed from $installed_source, but $source is declared; resolve the source change manually" >&2
          exit 1
        fi

        echo "Installing latest $id from $source"
        herdr plugin install "$source" --yes
      done < <(jq -c '.[]' <<<"$plugins_json")
    '';
  };
in
{
  home.packages = [ restoreHerdrPlugins ];

  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
      keys = {
        prefix = "ctrl+b";
        reload_config = "prefix+r";
        resize_mode = "";
        new_tab = "prefix+c";
        split_vertical = "prefix+|";
        split_horizontal = "prefix+minus";
        navigate_workspace_up = [ "up" "k" ];
        navigate_workspace_down = [ "down" "j" ];
        command = [
          {
            key = "ctrl+h";
            type = "plugin_action";
            command = "vim-herdr-navigation.left";
            description = "navigate left (vim/herdr)";
          }
          {
            key = "ctrl+j";
            type = "plugin_action";
            command = "vim-herdr-navigation.down";
            description = "navigate down (vim/herdr)";
          }
          {
            key = "ctrl+k";
            type = "plugin_action";
            command = "vim-herdr-navigation.up";
            description = "navigate up (vim/herdr)";
          }
          {
            key = "ctrl+l";
            type = "plugin_action";
            command = "vim-herdr-navigation.right";
            description = "navigate right (vim/herdr)";
          }
        ];
      };

      theme = {
        name = "terminal";
        auto_switch = true;
        dark_name = "terminal";
        light_name = "terminal";
        custom = {
          dark = {
            accent = "#C1A78E";
            panel_bg = "#292522";
            sidebar_bg = "#292522";
            active_row_bg = "#34302C";
            selection_bg = "#403A36";
            surface0 = "#34302C";
            surface1 = "#403A36";
            surface_dim = "#292522";
            overlay0 = "#867462";
            overlay1 = "#C1A78E";
            text = "#ECE1D7";
            subtext0 = "#C1A78E";
            mauve = "#B380B0";
            green = "#78997A";
            yellow = "#EBC06D";
            red = "#BD8183";
            blue = "#7F91B2";
            teal = "#7B9695";
            peach = "#E49B5D";
          };
          light = {
            accent = "#A06D00";
            panel_bg = "#F1F1F1";
            sidebar_bg = "#F1F1F1";
            active_row_bg = "#E9E1DB";
            selection_bg = "#D9D3CE";
            surface0 = "#E9E1DB";
            surface1 = "#D9D3CE";
            surface_dim = "#F1F1F1";
            overlay0 = "#A98A78";
            overlay1 = "#7D6658";
            text = "#54433A";
            subtext0 = "#7D6658";
            mauve = "#BE79BB";
            green = "#6E9B72";
            yellow = "#A06D00";
            red = "#C77B8B";
            blue = "#7892BD";
            teal = "#739797";
            peach = "#BC5C00";
          };
        };
      };

      ui = {
        sidebar_collapsed_mode = "compact";
        status_indicators = "symbols";
        sound.enabled = false;
      };
    };
  };
}
