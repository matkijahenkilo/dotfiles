{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
    ];
    functions = {
      asd = "yt-dlp -f mp4 $argv[1]";
      asdx = "yt-dlp -x --audio-format mp3 $argv[1]";
      qwe = "gallery-dl -D ./ $argv[1]";
      nanakofetch = "command fastfetch --logo-width 42 --logo-height 25 --logo ~/Pictures/.fastfetch.jpg";
    };
    loginShellInit = ''
      set QT_IM_MODULE
      set GTK_IM_MODULE
    '';
  };
}
