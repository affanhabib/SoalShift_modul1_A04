
#!/bin/bash

echo "A. Negara dengan Penjualan Terbanyak:"
awk -F ',' '{if($7=="2012") qnt[$1]+=$10;} END {for(i in qnt) print qnt[i] "-" i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -1 | awk -F '-' '{print "- " $2}'

echo "B. 3 Product Line Teratas pada Negara dengan Penjualan Terbanyak:"
awk -F ',' '{if($7=="2012" && $1=="United States") qnt[$4]+=$10;} END{for(i in qnt) print qnt[i] "-" i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -3 | awk -F '-' '{print "- " $2}'

echo "C. 3 Product Teratas pada Product Line Teratas:"
awk -F ',' '{if($7=="2012" && $1=="United States" &&($4=="Personal Accessories" || $4=="Outdoor Protection" || $4=="Camping Equipment")) qnt[$6]+=$10;} END {for(i in qnt) print qnt[i] "-" i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -3 | awk -F '-' '{print "* " $2}'
