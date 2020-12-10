#!/bin/bash

wget -q https://www.ynetnews.com/category/3082 -O list.txt

grep -o "https://www.ynetnews.com/article/[a-ZA-Z0-9]\{9,\}" list.txt > link_list.txt

sort link_list.txt | uniq > uniq.txt

grep -x '.\{42\}' uniq.txt > filtered.txt

cat filtered.txt | wc -l > results.csv 

for link in `cat filtered.txt`; do
	wget -q $link -O tmp.txt

	gantz_num=`grep Gantz tmp.txt | wc -l`
	nehentanyahu_num=`grep Netanyahu tmp.txt | wc -l`
	echo -n "$link, " >>results.csv

	if [[ gantz_num -eq 0 && nehentanyahu_num -eq 0 ]]; then
		echo '-' >>results.csv

	else
		echo 'Netanyahu, '$nehentanyahu_num', Gantz, '$gantz_num >> results.csv 

	fi
done
