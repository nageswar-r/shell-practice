#!/bin/bash

NUMBER=$1

# -gt -> greater than
# -ls -> less than
# -eq -> equal to 
# -ne -> not equal

if [ $NUMBER -gt 20 ]; then
    echo "Given number: $NUMBER is greater than 20"
elif [ $NUMBER -eq 20 ]; then
    echo "Given number: $NUMBER is equal to 20"
else
    echo "Given number: $NUMBER is less than 20"
fi