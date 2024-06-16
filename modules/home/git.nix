{ ... }: {
  programs.git = {
    enable = true;
    userName = "matkijahenkilo";
    userEmail = "matkija.henkilo@gmail.com";
    delta.enable = true;
    extraConfig = {
      delta.navigate = true;
      diff.algorithm = "histogram";
      init.defaultBranch = "master";
      merge.conflictStyle = "zdiff3";
      pull.rebase = true;
      rebase.autosquash = true;
      rerere.enabled = true;
      user.editor = "nvim";
    };
    ignores = [
      "*~"
      "*.swp"
      ".idea"
      ".vscode"
      ".direnv"
    ];
    aliases = {
      s = "status";
      d = "diff";
      a = "add";
      c = "commit";
      ca = "commit --amend";
      can = "commit --amend --no-edit";
    };
    signing = {
      key = "A1F1B36F06AB29ECA2C85BA2523C357756BA411C";
      signByDefault = true;
    };
  };
}
