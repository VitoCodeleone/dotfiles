#!/bin/bash

# Not my own work. Credit to original author
# Optimized bars animation without much CPU usage increase

bar="▁▂▃▄▅▆▇█"
dict="s/;//g"

# Calculate the length of the bar
bar_length=${#bar}

# Build sed substitution dictionary
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

# Create temporary Cava config for PipeWire
config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
framerate = 60
bars = 14

[input]
method = pipewire
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Kill previous Cava instances using this config
pkill -f "cava -p $config_file"

# Run Cava and replace numbers with bars
cava -p "$config_file" | sed -u "$dict"

