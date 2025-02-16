{ ... }: {
  # for firefox:
  # about:config
  # switch browser.shell.checkDefaultBrowser to false
  home.sessionVariables = {
    "XDG_DESKTOP_PORTAL" = 1;
    "GTK_USE_PORTAL" = 1;
  };
}