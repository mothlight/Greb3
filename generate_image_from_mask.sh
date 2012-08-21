#!/bin/bash
#input is mask of switches, i.e. 0011001100, assuming 10 switches 
#check which bits are set to 1 and include that overlay image as part of the generated image
#echo $1
maskStr=$1
maskLen=${#maskStr}
# intended image size should be corrected
convertStr='convert -size 1449x793 xc:white '

## convert -size 1449x793 xc:white -page +5+10 1.png -page +200+200 2.png -page +400+400 3.png -layers flatten  generate.png
#echo $maskLen

for ((count=1; count<=maskLen; count++))
do  
  #echo `expr substr $maskStr $count 1`
  if [ `expr substr $maskStr $count 1` -eq 1 ]; then
         #echo 'found 1 at pos '$count
         # position of each overlay within the image (-page +5+10) needs to be finalized
         case $count in
           1) # atmosphere
             convertStr=$convertStr' -page +5+10 1.png '
           ;;
           2) # diffusion of heat
             convertStr=$convertStr' -page +15+20 2.png '
           ;;
           3) #advection of heat
             convertStr=$convertStr' -page +5+30 3.png '
           ;;
           4) #CO2
             convertStr=$convertStr' -page +5+40 4.png '
           ;;
           5) #oceans
             convertStr=$convertStr' -page +5+50 5.png '
           ;;
           6) #hydrological cycle
             convertStr=$convertStr' -page +5+60 6.png '
           ;;
           7) #diffusion of water vapor
             convertStr=$convertStr' -page +5+70 7.png '
           ;;
           8) #advection of water vapor
             convertStr=$convertStr' -page +5+80 8.png '
           ;;
           9) #clouds
             convertStr=$convertStr' -page +5+90 9.png '
           ;;
           10) #ice-albedo
             convertStr=$convertStr' -page +5+100 10.png '
           ;;
         esac
  fi 
done

convertStr=$convertStr' -layers flatten  mean_thumb_'$maskStr'.png'
echo $convertStr
