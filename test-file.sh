#!/bin/bash
# first input, Harlem shake, reperesents a long running video, like a cam, that is meant to be displayed small in a corner
# second input, rn_image_picker_lib_temp_9022ea4a-4ad6-4ca6-ae00-cf9b4ace9755.mp4
# is a shorter video meant to be looped in the background

# scale=size=480,
#ffmpeg -i Harlem_Shake_.mp4 -i background_hacienda.mp4 \
#-filter_complex '[1:v]scale=320:240,loop=0,setpts=N/FRAME_RATE/TB[ovrl],[0:v][ovrl]overlay[out]' \
#ffmpeg -i rtsp://minibun:aquarium@192.168.100.182/stream1 \
#-filter_complex "movie=background_hacienda_slow.mp4:loop=0,setpts=N/FRAME_RATE/TB[bg];[0:v]scale=iw/2:-1,pad=iw+20:ih+20:10:10:color=yellow[m]; [bg][m]overlay=shortest=1:x=(W-w):y=0[out]" \
#-map '[out]' \
#-vcodec libx264 -r 12 -ar 22050 -b:v 2500k -maxrate 2500k -bufsize 5000k -preset veryfast -g 24 -keyint_min 60 \
#-f flv \
#rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_STREAM_KEY

VBR="2500k"                                    # Bitrate de la vidéo en sortie
FPS="30"                                       # FPS de la vidéo en sortie
QUAL="medium"                                  # Preset de qualité FFMPEG
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  # URL de base RTMP youtube

#SOURCE="udp://239.255.139.0:1234"              # Source UDP (voir les annonces SAP)
#SOURCE="Harlem_Shake_.mp4"              # Source mp4 (voir les annonces SAP)
SOURCE="https://video-weaver.hel03.hls.ttvnw.net/v1/playlist/CsoGwNqrUulAvlzU4-ynBrSJ26TSSK1SfED2G-qe5YgoUgmlmDHGkklGofLUTHNKIs6jWXs0XkYECh_ZgQXjbmnEIUKzLrcF2gV4vc7lLYVcIM6ZrSdw-ke6Ja4CuU1qyNa07p8aS2FjI1vL_wUrOp-q0HfkuHF9yqUQ9thCbL2kFr1itHHuuw8ESVf7uwNEClHUaI03rjmQjEpI_8zSD0hU_es68gm68O_893PZl_xwnhlVSw0lvDoSmxTjRlfFUW029o4qJbEavqdYw0P2UdBN3UZayTLhUsYBve_xnOsMIQVLjkiAlbSJp9hhi61B931xMYzDkax0DOC-jEwLEhPT4MI5UgqNtrFwYpdyVOKpGuEoo3Hp4n39bKrkSCAANEPDOoqZtrArjx3ts6wr_xpkFbt_2WE_z2gcjwbKPdHrGXJvZDluiMpz_aP5wa5xlpO1P00cZ-FkXs0Y04aN5lZvVXpXm0f4A3Wl97ZWKZxEzyA6-_JkRKZlJ8cNXCLJKlWV28GzU7LgaFVzy-RVijA92Z6JvdFi9ykowHhI9MVvGeM2DgdXstUS-x9HRzpYSxjZDfi6_wEsaSp1Y_38SvScrmQtzcVZfo10OzIjOdYYW6eSPyGhq-q9EIT09lznAB78crK5BNti60lxGb7qwHfRjDpeYeCEj_CHh5VlWNXNsbz-8wtHaJGXt0krTMT2ncVPuExNGp82K6NNr4RQ5ehTr8reEOApuA5x2hT2p1too8dGa1EtR-7DpFyQLYBy92cT-bEf7ZoCfDJ9GVa8IAq3UhU-XkCKXGmCs8LhxJ-hGz9q6zpWfgvYxL_MUaMUrPDrd5caz4WUu69eAjy858yDWrxlZyv_sj7WIDf3WuSI4HbhaOiOPIf7WWFUJkAkofODxWYE2EVyRKplA_xp1V6AD7kWjgNa29KBf19vcOCN-u2UwK9GwdC0Am5UVwPNco4A03ogwEP3i8ueUmphMYfbNIK7xm7nDgK5GxQVuyj9nWItX9CwCYVHxVYrPD8MdrB3h7seHCdw_dhcqvrpcvT9Yj4yy_okLfwGjPKidYDPWW-6zsYpp1gFxymeDZpwn6y3YI_SQRlZhvPPC4S7TojKlUz7xKyfh1WUbncaDLzjaxsAbPby73A9aCABKglldS13ZXN0LTIw4Ao.m3u8"              # Source mp4 (voir les annonces SAP)
KEY="...."                                     # Clé à récupérer sur l'event youtube

ffmpeg \
    -i "$SOURCE" \
    -filter_complex "movie=background_hacienda_slow.mp4:loop=0,setpts=N/FRAME_RATE/TB[bg]; [bg][0:v]overlay=shortest=1:x=(W-w):y=0[out]" \
    -map '[out]' \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -q:a 3 -b:a 712000 -bufsize 512k \
    out5.mp4

# to test, open video.sdp file with vlp while ffmpeg is running


#1. -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero : a dummy audio device that reports a valid audio format and sample rate for YouTube
#2. -f v4l2 : video format output from your camera
#3. -s 1920x1080 : camera's video resolution
#4. -r 30 : video framerate (I changed it from 25 to 30)
#5. -i /dev/video0 : input device (your webcam)
#6. -codec:v h264 : use h264 video codec
#7. -g 60 : group of pictures (GOP) interval (ideally twice your framerate, so 30x2)
#8. -b:v 2500k : video bitrate, in this case is 2.5Mbps, aka 2,500k, aka 2500000
#9. -codec:a aac -ac 2 -ar 44100 -ab 128k : audio stream options, but this one is not "real" as you're using an empty audio stream
#10. -f flv : output format (Flash video)
#11. rtmp://... : the RTMP stream you're using as your output
