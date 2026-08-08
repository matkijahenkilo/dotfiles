{ lib, pkgs, ...}:
{
  services = {
    llama-cpp = {
      enable = true;
      package = pkgs.llama-cpp-vulkan;
      settings = {
        models-dir = "/media/WD/models"; # switch to a better place lol
        sleep-idle-seconds = 1800;
        ui-mcp-proxy = true;
      };
    };
  };
}