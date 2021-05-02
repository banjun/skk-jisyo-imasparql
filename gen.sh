#!/bin/sh
idols_encoded=$(nkf -WwMQ gen-idols.rq | sed -e 's/=$//g' | tr = % | tr -d '\n')
idols_result=$(curl -s --fail "https://sparql.crssnky.xyz/spql/imas/query?query=$idols_encoded&format=text%2Fcsv" | tail +3 | sed '$d' | LC_ALL=C sort)
echo "$idols_result" | grep ';; okuri-nasi' > /dev/null && echo "$idols_result" > SKK-JISYO.im@sparql.idols.utf8

units_encoded=$(nkf -WwMQ gen-units.rq | sed -e 's/=$//g' | tr = % | tr -d '\n')
units_result=$(curl -s --fail "https://sparql.crssnky.xyz/spql/imas/query?query=$units_encoded&format=text%2Fcsv" | tail +3 | sed '$d' | LC_ALL=C sort)
echo "$units_result" | grep ';; okuri-nasi' > /dev/null && echo "$units_result" > SKK-JISYO.im@sparql.units.utf8

cat SKK-JISYO.im@sparql.{idols,units}.utf8 | LC_ALL=C sort | uniq > SKK-JISYO.im@sparql.all.utf8
