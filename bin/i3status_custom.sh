#!/bin/bash

SEPARATOR_BLOCK_WIDTH=31

insert_weather_json() {
  WEATHER_JSON=$(cat ~/.cli-weather-forecast)
  FIXED_LINE="[{\"full_text\": \"$WEATHER_JSON\"}, $@,"
}

insert_separator_width() {
  FIXED_LINE=$(echo $FIXED_LINE | sed "s/{/{\"separator_block_width\": $SEPARATOR_BLOCK_WIDTH, /g")
}

i3status | while :
do
  read LINE

  if echo "$LINE" | grep -qiE 'name'
  then
    FIXED_LINE=$(echo $LINE | sed  '0,/\[/ s/,*\[//')
    insert_weather_json $FIXED_LINE
    insert_separator_width $FIXED_LINE

    echo $FIXED_LINE
  else
    echo $LINE
  fi
done
