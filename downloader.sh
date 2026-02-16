#! /usr/bin/env bash

# Tips to make the script works: The Youtube playlist you want to download must not be "private"

playlist_dir=''
playlist_url='' # example: 'https://www.youtube.com/watch?v=HSbBSphYeZo&list=PL_VYblkIaVdrQNjBuorD7bBNzVNPCc_cs&pp=gAQB'

if [[ -z "${playlist_dir:-}" ]]
then
  printf 'Fill the ${playlist_dir} variable before running this script\n' >&2
  exit 1
fi

if [[ -z "${playlist_url:-}" ]]
then
  printf 'Fill the ${playlist_url} variable before running this script\n' >&2
  exit 1
fi

docker run -w /root \
           -v "$(dirname "${playlist_dir}")":/root \
           -v ~/.mozilla:/root/.mozilla \
           --rm \
           -it jauderho/yt-dlp:latest \
           -o "${playlist_dir}/[%(playlist)s] %(title)s.%(ext)s" \
           -N 4 \
           --cookies-from-browser firefox \
           -t mp3 \
           "${playlist_url}"

chown user:user "${playlist_dir}"/*
