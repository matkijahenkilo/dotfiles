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
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = true;
      core = {
        fsmonitor = true;
        untrackedcache = true;
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      fetch = {
        all = true;
        pruneTags = true;
        prune = true;
      };
      help.autocorrect = "prompt";
      init.defaultBranch = "master";
      merge.conflictStyle = "zdiff3";
      pull.rebase = true;
      push = {
        autoSetupRemote = true;
        default = "simple";
        followTags = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      rerere = {
        autoupdate = true;
        enabled = true;
      };
      tag.sort = "version:refname";
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
