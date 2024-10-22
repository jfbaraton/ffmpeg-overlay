#!/bin/bash
# scale=size=480,
ffmpeg -i Harlem_Shake_.mp4 -i rn_image_picker_lib_temp_9022ea4a-4ad6-4ca6-ae00-cf9b4ace9755.mp4 \
-filter_complex '[1:v]scale=320:240[ovrl],[0:v][ovrl]overlay[out]' \
-map '[out]' out.mp4