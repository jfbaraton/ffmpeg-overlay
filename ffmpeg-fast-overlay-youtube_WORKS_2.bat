@ECHO OFF
REM first input, Harlem shake, reperesents a long running video, like a cam, that is meant to be displayed small in a corner
REM second input, rn_image_picker_lib_temp_9022ea4a-4ad6-4ca6-ae00-cf9b4ace9755.mp4
REM is a shorter video meant to be looped in the background

REM scale=size=480,
REM ffmpeg -i Harlem_Shake_.mp4 -i background_hacienda.mp4 \
REM -filter_complex '[1:v]scale=320:240,loop=0,setpts=N/FRAME_RATE/TB[ovrl],[0:v][ovrl]overlay[out]' \
ffmpeg -loop 1 -i background.jpg ^
-rtbufsize 32M -i rtsp://minibun:aquarium@192.168.100.182/stream1 ^
-rtbufsize 32M -i rtsp://minibun:aquarium@192.168.100.182/stream1 ^
-i logo.png ^
-filter_complex "[1:v]pad=iw+8:ih+8:4:4:black[a]; [2:v]pad=iw+8:ih+8:4:4:black[b]; [0:v][a]overlay=30:(main_h/2)-(overlay_h/2)[c]; [c][b]overlay=main_w-overlay_w-30:(main_h/2)-(overlay_h/2)[tvideo]; [tvideo][3:v]overlay=x=(main_w-overlay_w)/2:y=(main_h-overlay_h)/2[video]; anullsrc=cl=mono:r=44100[audio]" ^
-map "[video]" -map "[audio]" ^
-c:v libx264 -pix_fmt yuv420p -tune zerolatency -crf 28 -x264-params keyint=20:scenecut=0 ^
-movflags +faststart ^
-flvflags no_duration_filesize ^
-f flv "rtmp://a.rtmp.youtube.com/live2/"%YOUTUBE_STREAM_KEY%

REM to test, open video.sdp file with vlp while ffmpeg is running


REM -f lavfi -i anullsrc ^
REM -acodec libmp3lame -ar 44100 -threads 6 -q:a 3 -b:a 712000 -bufsize 512k ^


REM -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero : a dummy audio device that reports a valid audio format and sample rate for YouTube
REM -f v4l2 : video format output from your camera
REM -s 1920x1080 : camera's video resolution
REM -r 30 : video framerate (I changed it from 25 to 30)
REM -i /dev/video0 : input device (your webcam)
REM -codec:v h264 : use h264 video codec
REM -g 60 : group of pictures (GOP) interval (ideally twice your framerate, so 30x2)
REM -b:v 2500k : video bitrate, in this case is 2.5Mbps, aka 2,500k, aka 2500000
REM -codec:a aac -ac 2 -ar 44100 -ab 128k : audio stream options, but this one is not "real" as you're using an empty audio stream
REM -f flv : output format (Flash video)
REM rtmp://... : the RTMP stream you're using as your output
