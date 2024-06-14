{ ... }: {
  programs.fish = {
    enable = true;
    functions = {
      asd = {
        body = "yt-dlp -f mp4 $argv[1]";
      };
      qwe = {
        body = "gallery-dl -D ./ $argv[1]";
      };
      nanakofetch = {
        body = "command fastfetch --logo-width 42 --logo-height 25 --logo ~/Pictures/fastfetch.jpg";
      };
    };
  };
}
