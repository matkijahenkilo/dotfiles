{ config, ... }: {
  programs.nh.clean.enable = config.programs.nh.enable;
}
