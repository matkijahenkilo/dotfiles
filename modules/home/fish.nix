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
    };
  };
}
