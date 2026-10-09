# Environment variables (define before use)
export BUN_INSTALL="$HOME/.bun"

# PATH configuration (consolidated for efficiency)
typeset -U PATH  # Ensure unique entries only
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
path=(
    /opt/homebrew/bin
    /usr/local/opt/rustup/bin
    $BUN_INSTALL/bin
    $path
    $HOME/.jenv/bin:$PATH
    $PATH:/Users/jeroen/.dotnet/tools
)

export PATH

# Source cargo environment (adds ~/.cargo/bin to PATH)
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"


# Vite+ bin (https://viteplus.dev)
. "$HOME/.config/vite-plus/env"
