#!/bin/bash
# cboe-cnbc.sh

trap 'STOP=true' SIGINT SIGQUIT SIGTERM

STOP=false
LINK="https://www.cnbc.com/quotes/?symbol=@XBT.1&amp;tab=news"

while [ "$STOP" != true ]
do
  clear
  wget -q -O- "$LINK" | \
    sed 's/<\/span>/&\n/g' | \
    grep "quoteData\['@XBT\.1'\]\.last" | \
    tail -1 | \
    sed 's/<span[^>]*>//g;s/<\/span>$//g; s/[ \t]*//g'
  sleep 3
done


