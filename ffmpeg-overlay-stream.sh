#!/bin/bash
# first input, Harlem shake, reperesents a long running video, like a cam, that is meant to be displayed small in a corner
# second input, rn_image_picker_lib_temp_9022ea4a-4ad6-4ca6-ae00-cf9b4ace9755.mp4
# is a shorter video meant to be looped in the background

# scale=size=480,
#ffmpeg -i Harlem_Shake_.mp4 -i rn_image_picker_lib_temp_9022ea4a-4ad6-4ca6-ae00-cf9b4ace9755.mp4 \
#-filter_complex '[1:v]scale=320:240,loop=0,setpts=N/FRAME_RATE/TB[ovrl],[0:v][ovrl]overlay[out]' \
ffmpeg -i https://video-weaver.hel03.hls.ttvnw.net/v1/playlist/CpoGsGgSAYks6PeL5pWaUME3sAJB6PYZx9ZEErzsaZ7sBaB0u3ijPTAq2xVNOtP56xazHhEqs1gEYuo_4IrkmN-itZT_HGDR3-KXUtzIfkalBlsofg6KeKRJ7w0L2qYtG8r33hDTtolKOzJGysavJyd3EL3xj78fhXsKY-2ZN2Z4Z7uUtzSWGADRLqXjM6Qmaxc5FjtcG1srw_B9O8o7MofzSQKfnknITdrMnoBw_KbdHX_oAH-t5nfrRr4ph5vwnG0H7UwlP4aq5qkIUpM2nz3j7niuUBnpMn0UB1aoXBnwtlHoW5ozyHjPL_BmEemiU5OHJcWjxZvPkX0xsp6knuNnyZfOGnJDoXEPSO4qf-Yjy3hNX7AAY0HqIAUsUTRmV9yVGsNAzaoe-BFu_yAct-vllqwx4zUBxU62nSc5SCdm33OTlObyk27z3OFfayspSTndHqRhi0XCr__fwUHzQpw4oxHn0TwCAOALJVUxmgUHkfUSl6Kd4kZtcUPEKhNDs3b8zU9vMXEUWNRyCSqM1_tTEW5ydBIq_OXxqnMAXWUnB_RG7LVSZVGzgFDjyPu2kdeigOXj5jcKhUktTOI54nKfFgsqJY2uhtgvUt3Wj_OYOVmwH7IpUuofoBiVin0j2LqZ49a50HTn_Wnt5P6wqrbA624AWq_6ZPQxpZuKrQU7bF7st3t_dzS77-qcDMZFcYet57_DXWl1FmSApmRLiatZ1rdeM8JP2Rxi5EsNwQ183www8K6xPEQ9XUy-qakFz41E99IItqhbWXkHSKEb7gqJpK0fc2Bw9-icrV1myJ88HunjeOKCdvuuQWhVx3L9jwJfOSXu9vIr8rHfXeDb0_1kYIS5Q4DnZk-ChNoGzSRboBF2tPqFqnPrdbl7pHf28ainqeteO7Bt001NV5MWbO8Q8EDeoj2BGEj00Dmu4yuy2d4iFI5l1eqn9lefEZnFh8gUocQEoo9S7yoLjlsLLBy5p6vrGJkNtXRaucCPMhruEi-cQIrFcdTjApR6cUwXybbmOQhQz5l0cbYRiKWEMKoc7lsX-DnsRzpPoroaDL5KYB_U_u3weA6THyABKglldS13ZXN0LTIw1wo.m3u8 \
-filter_complex "movie=rn_image_picker_lib_temp_9022ea4a-4ad6-4ca6-ae00-cf9b4ace9755.mp4:loop=0,setpts=N/FRAME_RATE/TB,hue=s=0[bg];[0:v]scale=iw/2:-1,pad=iw+20:ih+20:10:10:color=yellow[m]; [bg][m]overlay=shortest=1:x=(W-w):y=0[out]" \
-map '[out]' \
-f rtp \
-sdp_file video.sdp \
rtp://127.0.0.1:5004

# to test, open video.sdp file with vlp while ffmpeg is running