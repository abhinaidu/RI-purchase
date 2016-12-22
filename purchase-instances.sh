#!/bin/bash

echo "Please enter the count:"
read count

while read p
do 
#	echo "Please enter the count:"
#	read count
	aws ec2 purchase-reserved-instances-offering --dry-run --reserved-instances-offering-id "$p" --instance-count "$count"
done < ./RI-list.txt
