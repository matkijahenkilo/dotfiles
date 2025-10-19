{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "matkijahenkilo";
        email = "matkija.henkilo@gmail.com";
        editor = "micro";
      };
      diff.algorithm = "histogram";
      init.defaultBranch = "master";
      merge.conflictStyle = "zdiff3";
      pull.rebase = true;
      rebase.autosquash = true;
      rerere.enabled = true;
      alias = {
        s = "status";
        d = "diff";
        a = "add";
        c = "commit";
        ca = "commit --amend";
        can = "commit --amend --no-edit";
        l = "log --oneline --graph";
      };
    };
    ignores = [
      "*~"
      "*.swp"
      ".idea"
      ".vscode"
      ".direnv"
    ];
    signing = {
      key = "A1F1B36F06AB29ECA2C85BA2523C357756BA411C";
      signByDefault = true;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
