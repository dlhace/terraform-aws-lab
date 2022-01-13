#!/bin/sh
display_usage() { 
	echo "This script must be run with the name of a variable set" 
	echo "\nUsage: $0 [var set] \n" 
	} 
# if less than two arguments supplied, display usage 
if [  $# -le 0 ] 
  then 
	display_usage
	exit 1
fi 
vpc_name=$1
terraform apply -var-file=vars/${vpc_name}.tfvars -state=state/${vpc_name}.tfstate
