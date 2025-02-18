{ lib, ... }: {
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
    };
  };
  xdg.configFile = {
    "micro/bindings.json" = {
      text = ''
        {
          "Alt-/": "lua:comment.comment",
          "CtrlUnderscore": "lua:comment.comment",
          "Ctrl-w": "Quit",
          "Ctrl-s": "Save,Quit",
        }
      '';
    };
  };
  home.sessionVariables = {
    EDITOR = lib.mkDefault "micro";
  };
}