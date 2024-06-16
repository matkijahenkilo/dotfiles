{ ... }: {
  programs.fish = {
    enable = true;
    functions = {
      asd = "yt-dlp -f mp4 $argv[1]";
      asdx = "yt-dlp -x --audio-format mp3 $argv[1]";
      qwe = "gallery-dl -D ./ $argv[1]";
      nanakofetch = "command fastfetch --logo-width 42 --logo-height 25 --logo ~/Pictures/fastfetch.jpg";
    };
  };
}
