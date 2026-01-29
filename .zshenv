# Environment variables (define before use)
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export BUN_INSTALL="$HOME/.bun"

# PATH configuration (consolidated for efficiency)
typeset -U PATH  # Ensure unique entries only

path=(
    /opt/homebrew/bin
    $HOME/.jenv/bin
    /usr/local/opt/rustup/bin
    $BUN_INSTALL/bin
    $HOME/.dotnet/tools
    $path
    $ANDROID_HOME/emulator
    $ANDROID_HOME/tools
    $ANDROID_HOME/tools/bin
    $ANDROID_HOME/platform-tools
    $ANDROID_HOME/cmdline-tools/latest/bin
)

export PATH

# Source cargo environment (adds ~/.cargo/bin to PATH)
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
