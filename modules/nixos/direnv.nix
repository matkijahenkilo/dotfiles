{ ... }:
{
  programs.direnv = {
    enable = true;
    loadInNixShell = true;
    enableZshIntegration = true;
  };
}
