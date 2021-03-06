#!/bin/bash
# cboe.sh

STOP=false
LINK='http://cfe.cboe.com/cfe-products/xbt-cboe-bitcoin-futures'

trap 'STOP=true' SIGINT SIGQUIT SIGTERM

while [ "$STOP" != true ];
do
  clear

  STR='<td width="12%" style="text-align: right;" class="right">'

  # Parse price and change fields (the ugly way)
  DATA=$(wget -q -O- "$LINK" | \
    sed 's/<\/div>/&\n/g' | \
    grep "$STR" | \
    sed "s/$STR//g; s/<\/td>//g" | \
    head -2 | \
    sed "s/<span class='numeric-negative'>//g" | \
    sed "s/<\/span>//g; s/^[ \t]*//g")
  
  PRICE=$(echo "$DATA" | head -1)
  CHANGE=$(echo "$DATA" | tail -1)

  echo "GXBT: $PRICE"
  echo "Change: $CHANGE"

  sleep 3
done

