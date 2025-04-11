{ ... }: {
  # its mini toolbar can stop your interaction with
  # the entire virtualbox program once you go fullscreen
  # run this after installing it
  # VBoxManage setextradata global GUI/ShowMiniToolBar false
  virtualisation.virtualbox = {
    host = {
      enable = true;
    };
  };
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ]; # https://discourse.nixos.org/t/issue-with-virtualbox-in-24-11/57607/2
}