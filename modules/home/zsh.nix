{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.zsh.ffmpegFunctions.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
  config = {
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
        let
          pkgZshGitPrompt =
            inputs.nixpkgs-zsh-git-prompt.legacyPackages.${pkgs.stdenv.hostPlatform.system}.zsh-git-prompt;
        in
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

      initContent =
        let
          sounds-path = ../../assets/sounds;
          ffmpeg-with-progress = "${lib.getExe pkgs.python314Packages.ffmpeg-progress-yield} -p -x ${lib.getExe pkgs.ffmpeg}";
        in
        ''
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

        ''
        + lib.optionalString config.zsh.ffmpegFunctions.enable ''
          # Functions

          green()   { print -n -P "%F{green}$*%f" }
          cyan()    { print -n -P "%F{cyan}$*%f" }
          yellow()  { print -n -P "%F{yellow}$*%f" }
          red()     { print -n -P "%F{red}$*%f" }
          magenta() { print -n -P "%F{magenta}$*%f" }

          # chcodecs [file]
          # changes the video and audio codec of file to av1 and opus
          chcodecs() {
            setopt local_options err_return
            ${ffmpeg-with-progress} -i $1 -c:v libsvtav1 -c:a libopus "''${1%.*}-av1+opus.''${1##*.}"
            (${lib.getExe pkgs.mpv} --no-terminal ${sounds-path}/yume-nikki-music8.wav > /dev/null 2>&1 &)
          }

          # cutmedia [file] [start] [end]
          # e.g. cutmedia MGR姉貴かわいい.mp4 1:30 3:00
          cutmedia() {
            setopt local_options err_return
            local final_name="''${1%.*}-cut.''${1##*.}"
            ${lib.getExe pkgs.ffmpeg} -hide_banner -loglevel error -y -ss $2 -to $3 -i $1 -c copy $final_name
            echo "$(green Media cut and saved to \"''${final_name}\")"
          }

          # chvidsize [file] [size in mb (optional)] [ffmpeg preset (optional)]
          # e.g. chvidsize NYN姉貴ｗ.mp4 5 5
          chvidsize() {
            setopt local_options err_return
            local start_time=$SECONDS
            local target_size_mb target_size length length_round_up total_bitrate audio_bitrate video_bitrate max_video_bitrate preset

            target_size_mb=10 # discord size limit
            if [ ! -z $2 ]; then
              target_size_mb=$2
            fi
            preset=6
            if [ ! -z $3 ]; then
              preset=$3
            fi

            target_size=$(($target_size_mb * 1000 * 1000 * 8))

            length=`${pkgs.ffmpeg}/bin/ffprobe -v error -i $1 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1`
            length_round_up=$((''${length%.*} + 1))
            total_bitrate=$(($target_size / $length_round_up))
            audio_bitrate=$((128 * 1000))
            video_bitrate=$(($total_bitrate - $audio_bitrate))
            max_video_bitrate=$((2500 * 1000))

            if (( video_bitrate > max_video_bitrate )); then
              video_bitrate=$max_video_bitrate
            fi

            if (( video_bitrate < 200000 )); then
              audio_bitrate=$((64 * 1000))
              video_bitrate=$(($total_bitrate - $audio_bitrate))
            fi

            # 2 pass encoding is not worth it, it takes too much time
            # and doesn't make the quality better. So I'll use 1 pass instead.
            echo "$(cyan Encoding video with bitrate and preset arguments:) $(yellow -b:v $video_bitrate -b:a $audio_bitrate -preset $preset)"
            ${ffmpeg-with-progress} -hide_banner -loglevel error -y \
              -i $1 \
              -c:v libsvtav1 \
              -b:v $video_bitrate \
              -preset $preset \
              -c:a libopus \
              -b:a $audio_bitrate \
              "''${1%.*}-shrinked.''${1##*.}"

            echo "$(green Encoding completed in) $(yellow $(($SECONDS - $start_time))) $(green seconds)"
            echo "$(green Saved video to \"''${1%.*}-shrinked.''${1##*.})\""
            (${lib.getExe pkgs.mpv} --no-terminal ${sounds-path}/yume-nikki-music8.wav > /dev/null 2>&1 &)
          }

          # cutdiscordclip [file] [start] [end] [size in mb (optional)] [ffmpeg preset (optional)]
          # cuts a video and encode it, shrinking it's size below 10mb by default or a custom target value
          # e.g. cutdiscordclip 'MUSIC 22 11 2025.webm' 1:30 2:00 8 6
          cutdiscordclip() {
            setopt local_options err_return
            local cutVideoName="''${1%.*}-cut.''${1##*.}"

            echo "$(cyan Cutting video...)"
            cutmedia "$1" "$2" "$3"

            # Discord can't embed mkvs, so this kinda fixes it
            if [[ "''${cutVideoName##*.}" != "mp4" ]]; then
              echo "$(cyan Changing ''${file:t} to mp4)"
              local cutVideoNameMp4="''${cutVideoName%.*}.mp4"
              ${lib.getExe pkgs.ffmpeg} -hide_banner -loglevel error -y -i $cutVideoName -c copy $cutVideoNameMp4
              rm $cutVideoName
              cutVideoName=$cutVideoNameMp4
              echo "$(green Done)"
            fi

            if [ -z $4 ]; then
              echo "$(cyan Trying to not let the video size go past) $(magenta 10mb)$(cyan ...)"
            else
              echo "$(cyan Trying to not let the video size go past) $(magenta ''${4}mb)$(cyan ...)"
            fi

            if (($(${pkgs.ffmpeg}/bin/ffprobe -i "$cutVideoName" -show_entries format=size -v quiet -of csv="p=0") < 10000000 )); then
              echo "$(green Surprisingly, the video is already smaller than 10mb.)"
              return 0
            fi

            chvidsize "$cutVideoName" "$4" "$5"

            # delete intermediate video
            rm $cutVideoName
          }

          # mkgif [files]
          mkgif() {
            setopt local_options err_return
            local file
            for file in $@
            do
              ${ffmpeg-with-progress} -hide_banner -loglevel error -y -i $file -vf 'setpts=1*PTS' -c:v libwebp -loop 0 -pix_fmt yuva420p "''${file%.*}.webp"
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
            setopt local_options err_return
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

                echo "$(cyan Converting $fullFilePath to $steamScreenshotName)"
                ${lib.getExe pkgs.ffmpeg} -hide_banner -loglevel error -y -i $fullFilePath -q:v 2 -pix_fmt yuv444p $steamScreenshotName

                echo "$(cyan Resizing $steamScreenshotName for the thumbnails folder)"
                ${lib.getExe pkgs.ffmpeg} -hide_banner -loglevel error -y -i $steamScreenshotName -vf "scale=200:-2" "thumbnails/$steamScreenshotName"
              else
                ${lib.getExe pkgs.ffmpeg} -hide_banner -loglevel error -y -i $fullFilePath -q:v 2 -pix_fmt yuv444p "''${file%.*}.jpg"
              fi
            done
          }
        '';
    };
  };
}
