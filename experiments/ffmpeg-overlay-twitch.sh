#!/bin/bash
# first input, Harlem shake, reperesents a long running video, like a cam, that is meant to be displayed small in a corner
# second input, rn_image_picker_lib_temp_9022ea4a-4ad6-4ca6-ae00-cf9b4ace9755.mp4
# is a shorter video meant to be looped in the background

# scale=size=480,
#ffmpeg -i Harlem_Shake_.mp4 -i background_hacienda_slow.mp4 \
#-filter_complex '[1:v]scale=320:240,loop=0,setpts=N/FRAME_RATE/TB[ovrl],[0:v][ovrl]overlay[out]' \
ffmpeg -i rtsp://minibun:aquarium@192.168.100.182/stream1 \
-filter_complex "movie=background_hacienda_slow.mp4:loop=0,setpts=N/FRAME_RATE/TB[bg];[0:v]scale=iw/2:-1,pad=iw+20:ih+20:10:10:color=yellow[m]; [bg][m]overlay=shortest=1:x=(W-w):y=0[out]" \
-map '[out]' \
-vcodec libx264 -b:v 4500k -maxrate 4500k -bufsize 9000k -preset veryfast -g 60 -keyint_min 60 \
-f flv \
rtmp://live.twitch.tv/app/$TWITCH_STREAM_KEY

# to test, open video.sdp file with vlp while ffmpeg is running
