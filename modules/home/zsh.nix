{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    defaultKeymap = "emacs";

    history = {
      size = 10000;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      asd = "yt-dlp -f mp4 $argv[$]";
      asdx = "yt-dlp -x --audio-format mp3 $argv[$]";
      qwe = "gallery-dl -D ./ --ugoira-conv $argv[$]";
      nanakofetch = "command fastfetch --logo-width 42 --logo-height 25 --logo ~/Pictures/.fastfetch.jpg";
      m = "micro";
    };

    plugins = with pkgs; [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "zsh-git-prompt";
        file = "zshrc.sh";
        src = "${zsh-git-prompt}/share/zsh-git-prompt";
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.zsh";
        src = "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
      }
      {
        name = "zsh-history-substring-search";
        file = "zsh-history-substring-search.zsh";
        src = "${zsh-history-substring-search}/share/zsh-history-substring-search";
      }
    ];

    initExtraBeforeCompInit = ''
      zstyle ':completion:*' menu select
    '';

    initExtra = ''
      # History binds
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # Fix home/end/delete
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char

      # Prompt
      PROMPT='%F{green}%n%f%F{white}@%m%f %F{green}%1~%f$(git_super_status) $ '
      RPROMPT="%(?..%B%F{red}<FAIL>%b %?)%f "
    '';
  };
}
