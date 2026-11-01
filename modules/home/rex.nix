{ pkgs, ... }:
let
  rexWorktrunkSource = pkgs.fetchFromGitHub {
    owner = "haxybaxy";
    repo = "rex-worktrunk";
    rev = "024d12f2c152a0fbe46b2683e6c19873009b25f9";
    hash = "sha256-nva+LXCM4nCJoJT7TW41kIHcSoGmpqPjz9u7QjxrZ90=";
  };

  rexWorktrunk = pkgs.runCommand "rex-worktrunk" { } ''
        mkdir -p "$out"
        cp -R ${rexWorktrunkSource}/. "$out/"
        chmod -R u+w "$out"

        substituteInPlace "$out/init.lua" \
          --replace-fail '  script = nil,' '  script = nil,
      session_label = nil,' \
          --replace-fail 'end

    local function trim(s)' 'end

    local function session_name(path)
      if M.options.session_label then return M.options.session_label(path) end
      return basename(path)
    end

    local function trim(s)' \
          --replace-fail '  local name = basename(path)' '  local name = session_name(path)' \
          --replace-fail '  local session_id = find_session(basename(path))' '  local session_id = find_session(session_name(path))' \
          --replace-fail '  local known = { layout = true, script = true }' '  local known = { layout = true, script = true, session_label = true }'
  '';
in
{
  xdg.configFile."rex/init.lua".source = ../../config/rex/init.lua;

  xdg.configFile."rex/rex-worktrunk".source = rexWorktrunk;

  xdg.configFile."worktrunk/config.toml".text = ''
    worktree-path = "~/rex/worktrees/{{ repo }}/{{ branch | sanitize }}"
  '';
}
