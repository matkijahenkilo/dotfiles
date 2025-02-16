{ ... }: {
  programs.thunderbird = {
    enable = true;
    profiles = {
      matkija = {
        isDefault = true;
      };
    };
  };
}