#!/usr/bin/env bash
#
# Create a json file from gmt_colornames.h and gmt_color_rgb.h
#
# Steps:
# 1. Copy gmt_colornames.h and gmt_color_rgb.h to the same directory as this script
# 2. Run this script
# 3. Manually remove the last comma at line 556 from the json file
# 
json="gmt_colors.json"
echo "[" > $json
paste gmt_colornames.h gmt_color_rgb.h \
	| tr '{}' '"' \
	| sed s'/, /,/'g \
	| grep -v 'grey' \
	| awk -F'\t' '{printf("{\"name\":%s \"rgb\": %s},\n", $1, $2)}' \
	| sed s'/,}/}/'g >> $json
echo "]" >> $json
