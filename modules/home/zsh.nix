{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pkgZshGitPrompt =
    inputs.nixpkgs-zsh-git-prompt.legacyPackages.${pkgs.stdenv.hostPlatform.system}.zsh-git-prompt;
in
{
  home.packages = with pkgs; [
    fzf # to search stuff with ctrl+r
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    defaultKeymap = "emacs";

    history = {
      size = 10000;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      saveNoDups = true;
    };

    shellAliases = {
      asd = "yt-dlp -t mp4 $argv[$]";
      asdx = "yt-dlp -x --audio-format opus $argv[$]";
      asdxx = "yt-dlp -t mp3 $argv[$]";
      qwe = "gallery-dl --cookies ~/gallery-dl/cookies.txt -D ./ --ugoira-conv $argv[$]";
      nanakofetch = "command fastfetch --logo-width 42 --logo-height 25 --logo ~/Pictures/.fastfetch.jpg";
      ls = "ls -l --color=auto";
      la = "ls -la --color=auto";
      m = "micro";
    };

    plugins =
      with pkgs;
      [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = "${zsh-nix-shell}/share/zsh-nix-shell";
        }
        {
          name = "zsh-syntax-highlighting";
          file = "zsh-syntax-highlighting.zsh";
          src = "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
        }
        {
          name = "zsh-history-substring-search";
          file = "zsh-history-substring-search.zsh";
          src = "${zsh-history-substring-search}/share/zsh-history-substring-search";
        }
        {
          name = "zsh-fzf-history-search";
          src = "${zsh-fzf-history-search}/share/zsh-fzf-history-search";
        }
      ]
      ++ [
        {
          name = "zsh-git-prompt";
          file = "zshrc.sh";
          src = "${pkgZshGitPrompt}/share/zsh-git-prompt";
        }
      ];

    initContent = ''
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' menu select
      setopt COMPLETE_ALIASES
      zmodload zsh/complist

      # History binds
      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[OA" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search
      bindkey "^[OB" down-line-or-beginning-search

      # Fix home/end/delete
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char

      # Fix Ctrl+left/right
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # Don't delete an entire path with Alt + Backspace
      autoload -U select-word-style
      select-word-style bash

      # Prompt
      autoload -U colors && colors
      prompt() {
        [[ -v IN_NIX_SHELL ]] && PS1="%F{blue}(* ^ ω ^) " || PS1=""
        PS1="''${PS1}%F{green}%n%f%F{white}@%m%f %F{green}%1~%f$(git_super_status) $ "
        RPROMPT="%(?..%B%F{red}<FAIL>%b %?)%f "
      }
      precmd_functions+=prompt

      # Functions
      # chcodecs [file]
      # changes the video and audio codec of file to av1 and opus
      chcodecs() ${lib.getExe pkgs.ffmpeg} -i $1 -c:v libsvtav1 -c:a libopus "''${1%.*}-av1+opus.mp4"

      # cutvid [file] [start] [end]
      # e.g. cutvid MGR姉貴かわいい.mp4 1:30 3:00
      cutvid() ${lib.getExe pkgs.ffmpeg} -y -ss $2 -to $3 -i $1 -c copy "''${1%.*}-cut.mp4"

      # chvidsize [file] [size in mb (optional)]
      # e.g. chvidsize NYN姉貴ｗ.mp4 5
      chvidsize() {
        local target_size_mb target_size length length_round_up total_bitrate audio_bitrate video_bitrate
        target_size_mb=10 # discord size limit is 10mb
        if [ ! -z $2 ]; then # check if argument was specified
          target_size_mb=$2
        fi
        target_size=$(($target_size_mb * 1000 * 1000 * 8)) # target size in bits
        length=`${pkgs.ffmpeg}/bin/ffprobe -v error -i $1 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1`
        length_round_up=$((''${length%.*} + 1))
        total_bitrate=$(($target_size / $length_round_up))
        audio_bitrate=$((128 * 1000)) # 128k bit rate
        video_bitrate=$(($total_bitrate - $audio_bitrate))

        ${lib.getExe pkgs.ffmpeg} -y -i $1 -c:v libsvtav1 -c:a libopus -b:v $video_bitrate -b:a $audio_bitrate "''${1%.*}-shrinked.mp4"
      }

      # cutdiscordclip [file] [start] [end] [size in mb (optional)]
      # cuts a video and reenders it, shrinking it's size to 10mb by default or a custom target value
      # e.g. cutdiscordclip 'MUSIC 22 11 2025.mp4' 1:30 2:00 16
      cutdiscordclip() {
        local cutVideoName
        cutVideoName="''${1//.mp4/}-cut.mp4"

        echo 'cutting video'
        cutvid "$1" "$2" "$3"

        echo 'changing video size to $4mb'
        chvidsize "$cutVideoName" "$4"

        # delete intermediate video
        rm $cutVideoName
      }

      # mkgif [files]
      mkgif() {
        local file
        for file in $@
        do
          ${lib.getExe pkgs.ffmpeg} -y -i $file -vf 'setpts=1*PTS' -c:v libwebp -loop 0 -pix_fmt yuva420p "''${file%.*}.webp"
        done
      }

      # tojpg [files]
      #
      # when converting vrchat screenshots to jpg to upload on steam,
      # it might as well change the file name
      # and copy it to the thumbnails folder
      #
      # (but that only works if screenshots are taken from
      # vrchat's camera and the function is being
      # run inside steam's screenshots folder)
      tojpg() {
        local fullFilePath dir file temp cleanDigits steamScreenshotName
        for fullFilePath in "$@"
        do
          dir="''${fullFilePath%/*}/"
          file="''${fullFilePath##*/}"
          if [[ -d "thumbnails" && "$file" == VRChat_* ]]; then
            temp="''${file#VRChat_}"

            temp=''${temp[1,19]}

            cleanDigits="''${temp//[-_]/}"

            steamScreenshotName="''${cleanDigits}_1.jpg"

            echo "Converting $fullFilePath to $steamScreenshotName"
            ${lib.getExe pkgs.ffmpeg} -hide_banner -loglevel error -y -i $fullFilePath -q:v 2 -pix_fmt yuv444p $steamScreenshotName

            echo "Resizing $steamScreenshotName for the thumbnails folder"
            ${lib.getExe pkgs.ffmpeg} -hide_banner -loglevel error -y -i $steamScreenshotName -vf "scale=200:-2" "thumbnails/$steamScreenshotName"
          else
            ${lib.getExe pkgs.ffmpeg} -y -i $fullFilePath -q:v 2 -pix_fmt yuv444p "''${file%.*}.jpg"
          fi
        done
      }
    '';
  };
}
