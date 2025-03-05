{ lib, pkgs, ... }: {
  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      clipboard = "external";
      diffgutter = true;
      eofnewline = false;
      tabsize = 2;
      tabstospaces = true;
      savecursor = true;
      hlsearch = true;
      hltaberrors = true;
      hltrailingws = true;
      rmtrailingws = true;
      mkparents = true;

      lsp.server = "python=pyls,go=gopls,typescript=deno lsp,rust=rust-analyzer,nix=nixd";
      lsp.formatOnSave = true;
      lsp.ignoreMessages = "LS message1 to ignore|LS message 2 to ignore|...";
      lsp.tabcompletion = true;
      lsp.ignoreTriggerCharacters = "completion,signature";
      lsp.autocompleteDetails = false;
    };
  };

  xdg.configFile = {
    "micro/bindings.json".text = ''
      {
        "Alt-/": "lua:comment.comment",
        "CtrlUnderscore": "lua:comment.comment",
        "Ctrl-w": "Quit",
        "Ctrl-s": "Save,Quit",
      }
    '';

    # I'm dumb enough to not know how lsps works, let alone fix this.
    # Knowing how almost nobody knows about this editor, I doubt nixd would
    # have any support for this
    "micro/plug/lsp".source = builtins.fetchGit {
      url = "https://github.com/AndCake/micro-plugin-lsp";
      rev = "a3ed3a73b2f7576b1e2dc1ac3c98dfe695e6d05d";
    };
  };

  home.sessionVariables = {
    EDITOR = lib.mkDefault "micro";
    NIXD_FLAGS = "--inlay-hints=true";
  };

  home.packages = [ pkgs.nixd ];
}