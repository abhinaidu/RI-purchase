#!/usr/bin/bash

#Gets the region from the user
echo "The available regions in AWS are:" | aws ec2 describe-regions --query 'Regions[].{Name:RegionName}' --output table
echo "Enter the region in which the RI needs to be purchased"
read region
echo "The reserved instance will be purchased in the following region: $region"

#Gets the region based on the user input for region
echo "The availability zones in $region are: " | aws ec2 describe-availability-zones --filters "Name=region-name,Values=$region" --output table
echo "Enter the AZ in which the instance needs to be purchased in the above region:"
read az
echo "The AZ in which the RI will be purchases is: $az"

#Gets the user input regarding instance type
echo "Please enter the instance type to be purchased (eg: t2.micro):"
read instance
echo "The instance type selected for purchase is: $instance"

#Platform to be purchased
echo "Available platforms for purchase:
Linux/UNIX
SUSE Linux
Red Hat Enterprise Linux
Windows"
echo "Please enter the platform for the instance:"
read platform
echo "The platform selected is: $platform"

#Gets the instance tenancy
echo "Please enter the tenancy of the instance (dedicated/default):"
read tenancy
echo "The tenancy of the instance selected for purchase is: $tenancy"

#Gets the offering type
echo "Please enter the offering type from the following - No Upfront, Partial Upfront, All Upfront"
read offering
echo "The purchase offering type selected is: $offering"

#Duration of the instance that needs to be purchased
echo "Please enter the duration to purchase in secouds:
1 Year - 31536000 secoonds
3 Year - 94608000 seconds"
echo "Duration in seconds:"
read duration
echo "The duration for which the RI will be purchased is: $duration"

#Offering class for the RI to be purchased"
echo "Please enter the offering type to be purchased (standard/convertible):"
read offeringClass
echo "The offering class to be purchased is: $offeringClass"

#List of available RIs for purchase
echo "The list of available RIs for purchase are:" | aws ec2 describe-reserved-instances-offerings --instance-type "$instance" --availability-zone "$az" --instance-tenancy "$tenancy" --offering-type "$offering" --no-include-marketplace --offering-class "$offeringClass" --filters "Name=duration,Values=$duration" --product-description "$platform" --output text --query 'ReservedInstancesOfferings[*].ReservedInstancesOfferingId' > RI-list.txt
