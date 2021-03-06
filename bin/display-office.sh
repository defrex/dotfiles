#!/bin/sh
xrandr \
  --output VIRTUAL1 \
    --off \
  --output eDP1 \
    --primary \
    --mode 1920x1080 \
    --dpi 96 \
    --pos 3840x1080 \
    --rotate normal \
  --output DP1 \
    --mode 3840x2160 \
    --dpi 144 \
    --pos 0x0 \
    --rotate normal \
  --output HDMI2 \
    --off \
  --output HDMI1 \
    --off \
  --output DP2 \
    --off \

i3-msg reload
