# Environment variables (define before use)
export BUN_INSTALL="$HOME/.bun"

# PATH configuration (consolidated for efficiency)
typeset -U PATH  # Ensure unique entries only

path=(
    /opt/homebrew/bin
    /usr/local/opt/rustup/bin
    $BUN_INSTALL/bin
    $path
)

export PATH

# Source cargo environment (adds ~/.cargo/bin to PATH)
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
