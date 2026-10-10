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
      typeset -U path
      path=(
        "$HOME/.opencode/bin"
        $path
        /opt/homebrew/bin
        /usr/local/bin
      )
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
