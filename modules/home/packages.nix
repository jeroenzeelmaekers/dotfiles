{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aria2
    bat
    btop
    cargo
    colima
    difftastic
    eza
    fzf
    jq
    lazydocker
    lazygit
    nodejs
    ruby
    resvg
    ripgrep
    rustc
    starship
    yazi
    worktrunk
    zoxide
    wget
    (writeShellApplication {
      name = "device-hub";
      text = ''
        developer_dir="$(/usr/bin/xcode-select -p)"
        executable="$developer_dir/../Applications/DeviceHub.app/Contents/MacOS/DeviceHub"

        if [[ ! -x "$executable" ]]; then
          echo "Device Hub was not found in the selected Xcode: $executable" >&2
          exit 1
        fi

        if /usr/bin/pgrep -x DeviceHub >/dev/null; then
          echo "Device Hub is already running. Quit it first, then run device-hub again." >&2
          echo "Choose 'Quit and Keep Simulators Running' if Xcode offers that option." >&2
          exit 1
        fi

        log_file="$HOME/Library/Logs/device-hub.log"
        /usr/bin/nohup "$executable" </dev/null >>"$log_file" 2>&1 &
        pid=$!
        disown "$pid"

        echo "Started Device Hub (PID $pid). Log: $log_file"
      '';
    })
  ];
}
