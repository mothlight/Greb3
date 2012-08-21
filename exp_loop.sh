#!/bin/bash
#input is number of switches
let end=2**$1-1
#echo $end

#iterate through all possible switch combinations and generate command to create images
for ((count=0; count<=end; count++))
do  
  maskBinary=`echo "ibase=10; obase=2; ${count}" | bc`
  paddedMask=$(printf %0$1d $maskBinary)
  #echo $count'--'$paddedMask
  convertStr=`./generate_image_from_mask.sh $paddedMask`
  echo $convertStr
  # then actually run the convert command here in the next line
  # `$convertStr`
 
done

