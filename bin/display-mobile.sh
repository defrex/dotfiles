#!/bin/sh
xrandr \
  --output eDP1 \
    --primary \
    --mode 1920x1080 \
    --dpi 96 \
    --pos 0x0 \
    --rotate normal \
  --output VIRTUAL1 --off \
  --output DP1 --off \
  --output HDMI2 --off \
  --output HDMI1 --off \
  --output DP2 --off

i3-msg reload
