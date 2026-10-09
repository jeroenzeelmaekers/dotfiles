{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    setOptions = [ "HIST_REDUCE_BLANKS" ];
    history = {
      size = 5000;
      save = 5000;
      append = true;
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      saveNoDups = true;
      findNoDups = true;
      ignoreSpace = true;
      share = true;
      path = "$HOME/.zsh_history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    shellAliases = {
      ls = "eza --color=always";
      cat = "bat";
      vim = "nvim";
      lg = "lazygit";
      ld = "lazydocker";
      lq = "lazysql";
      oc = "opencode";
    };

    envExtra = ''
      export BUN_INSTALL="$HOME/.bun"
      typeset -U path
      path=(
        "$BUN_INSTALL/bin"
        "$HOME/.local/share/vite-plus/bin"
        "$HOME/.jenv/bin"
        "$HOME/.dotnet/tools"
        "$HOME/.opencode/bin"
        $path
        /opt/homebrew/bin
        /usr/local/bin
        /usr/local/opt/rustup/bin
      )
      export PATH
      [[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
    '';

    initContent = ''
      if (( $+commands[rbenv] )); then
        eval "$(rbenv init - zsh)"
      fi
      if (( $+commands[nodenv] )); then
        eval "$(nodenv init -)"
      fi
      if (( $+commands[jenv] )); then
        eval "$(jenv init -)"
        java_home="$(jenv javahome 2>/dev/null)"
        if [[ -n "$java_home" ]]; then
          export JAVA_HOME="$java_home"
          path=("$JAVA_HOME/bin" $path)
        fi
        unset java_home
      fi
      [[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
      [[ -f "$HOME/.config/vite-plus/env" ]] && source "$HOME/.config/vite-plus/env"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd" "cd" ];
  };
}
