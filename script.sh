#!/bin/sh

# Simple music controller by Anon.
###########################################

###########################################
# UTILS
############################################

FILE=$0

# Write first argument in stderr.
stderr() {
    echo $1 >&2
}

# Write first argument in stdin.
stdin() {
    echo -e $1
}

# Alias on stdin.
# Usefull if you want to display a blank line;
alias nl="stdin"

###########################################

# Play sounds.
#
# Use vlc.
play() {
    case $1 in
        '')
            shift
            vlc .
            ;;
        random)
            shift
            vlc --random .
            ;;
        *)
            vlc $1
            ;;
    esac
}

# Download music from youtube.
# Default output format is mp3.
#
# Use youtube-dl (https://github.com/rg3/youtube-dl).
download_youtube() {
    case $1 in
        mp3)
            shift
            youtube-dl -x --embed-thumbnail --audio-format mp3 $1
            ;;
        *)
            youtube-dl -x --embed-thumbnail --audio-format mp3 $1
            ;;
    esac
}

# Choose a download method, by default youtube.
download() {
    case $1 in
        youtube)
            shift
            download_youtube $@
            ;;
        *)
            download_youtube $@
            ;;
    esac
}

show_help() {
    stdin "Usage: $FILE [play|download|help]"
    stdin "Download and play music."
    nl
    stdin "Options:"
    stdin "\tplay (default: play sounds)"
    stdin "\t\trandom: Play sounds randomly"
    nl
    stdin "\tdownload (default: youtube)"
    stdin "\t\tyoutube: (default: mp3)"
    stdin "\t\t\tmp3: Download to mp3 file format"
    nl
    stdin "Examples:"
    stdin "\t$FILE play"
    stdin "\t$FILE play random"
    nl
    stdin "\t$FILE download <URL>"
    stdin "\t$FILE download youtube mp3 <URL>"
}

# Main switch case.
case $1 in
    play)
        shift
        play $@
        ;;
    download)
        shift
        download $@
        ;;
    help)
        shift
        show_help
        ;;
    *)
        show_help
        ;;
esac
