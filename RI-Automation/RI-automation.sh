#!/bin/bash

while IFS=, read -r f1 f2 f3 f4 f5 f6 f7 f8 f9
do
  echo "The region is $f1"
  echo "The AZ is $f2"
  echo "The InstanceType is $f3"
  echo "The Platform is $f4"
  echo "The Tenancy is $f5"
  echo "The Duration is $f6"
  echo "The OfferingClass is $f7"
  echo "The Offering is $f8"
  echo "The instance count is $f9"

echo "The list of available RIs for purchase are:" | aws ec2 describe-reserved-instances-offerings --instance-type "$f3" --instance-tenancy "$f5" --offering-type "$f8" --offering-class "$f7" --no-include-marketplace --filters "Name=duration,Values=$f6" --filters "Name=scope,Values=Region" --product-description "$f4" --output text --query 'ReservedInstancesOfferings[*].ReservedInstancesOfferingId' > ./RI-list.txt

cat ./RI-list.txt >> RI-Consolidated.txt

while read p
do
        aws ec2 purchase-reserved-instances-offering --reserved-instances-offering-id "$p" --instance-count "$f9"
done < ./RI-list.txt

done < $1

