@ECHO OFF
echo rtmp://live.twitch.tv/app/%TWITCH_STREAM_KEY%






ffmpeg -i "Harlem_Shake_.mp4" ^
-vcodec libx264 -r 12 -ar 22050 -b:v 2500k -maxrate 2500k -bufsize 5000k -preset veryfast -g 24 -keyint_min 60 ^
-flvflags no_duration_filesize ^
-f flv "rtmp://a.rtmp.youtube.com/live2/pyr5-d98z-5vgv-3h4d-98rb"
