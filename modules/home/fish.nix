{ ... }: {
  programs.fish = {
    enable = true;
    functions = {
      asd = {
        body = "yt-dlp -f mp4 $argv[1]";
        onEvent = "Ran yt-dlp";
      };
    };
  };
}
