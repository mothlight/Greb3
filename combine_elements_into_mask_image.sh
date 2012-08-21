echo $1
maskStr=$1
maskLen=${#maskStr}

convertStr='convert -size 916x652 xc:white  '

TATOMSQATMOS='-page +1+1 Tatmos-qatmos_t.png'
CLOUD='-page +136+148 BigBlueCloud_t.png'
SUN='-page +342+20 Sun_t.png'
BLACKDOTTED='-page +543+8 BlackVerticalDottedLine.png'
BLUEDOTTEDOCEAN='-page +1+520 BlueDottedUnderOceanLine.png'
BLUEOCEAN='-page +1+408 BlueWavyOceanSurface_t.png'
BLUECIRCLE='-page +489+161 DarkBlueLeftRightCircularHortzArrows_t.png'
BLUEBOLDARROW='-page +489+54 DarkBlueRightBoldThickArrow_t.png'
BROWNCIRCLE='-page +489+228 LeftRightCircularHorzArrows_t.png'
ICE='-page +449+398 Ice_t.png'
FLATGROUND='-page +1+422 LeftBlackFlatGround.png'
LEFTDOWNSUN='-page +292+87 LeftDIagonalMediumYellowArrow_t.png'
LEFTDOWNBIGSUN='-page +224+110 LeftDownYellowArrow_t.png'
LEFTUPSUN='-page +228+78 LeftUpDiagonalMediumYellowArrow_t.png'
RAINDROPS='-page +175+222 RainDrops_t.png'
REDMOUNTAINUP='-page +707+266 RedUpArrow_t.png'
REDCIRCLE='-page +40+272 RedUpDownCircleArrows_t.png'
BLACKHILL='-page +595+330 RightBlackHill_t.png'
RIGHTDOWNSUN='-page +413+110 RightDownYellowArrow_t.png'
ORANGEBOLDARROW='-page +489+110 RightOrangeBoldThickArrow_t.png'
REDCLOUDDOWN='-page +226+224 RightUpperBiggerDownArrow_t.png'
REDUP='-page +728+22 RightUpperBiggerUpArrow_t.png'
REDDOWN='-page +728+157 RightUpperBiggerDownArrow_t.png'
REDSMALLDOWN='-page +702+162 RightUpperSmallDownArrow_t.png'
REDSMALLUP='-page +702+62 RightUpperSmallUpArrow_t.png'
SMALLRIGHTUPYELLOW='-page +512+343 SmallRightUpYellowArrow_t.png'
TATMOS='-page +2+115 Tatmos_t.png'
TOCEAN='-page +2+543 Tocean_t.png'
TSURF='-page +2+437 Tsurf_t.png'
UPPERTHREEWAVY='-page +663+109 UpperRightBlueAndGreenAndLightBlueDottedWavyLines_t.png'
UPPERTWOWAVY='-page +662+110 UpperRightBlueAndGreenDottedWavyLines_t.png'
UPPERONEWAVY='-page +660+111 UpperRightBlueDottedWavyLine_t.png'
BLUEWAVYDOTTED='-page +311+303 WavyDottedUpArrow_t.png -page +341+303 WavyDottedUpArrow_t.png -page +371+303 WavyDottedUpArrow_t.png'

#to combine all possible elements in an image
IMAGE=$TATOMSQATMOS' '$CLOUD' '$SUN' '$LEFTDOWNSUN' '$BLACKDOTTED' '$BLUEDOTTEDOCEAN' '$BLUEOCEAN' '$BLUECIRCLE' '$BROWNCIRCLE' '$BLUEBOLDARROW' '$ICE' '$FLATGROUND' '$LEFTDOWNBIGSUN' '$LEFTUPSUN' '$RAINDROPS' '$REDMOUNTAINUP' '$REDCIRCLE' '$BLACKHILL' '$RIGHTDOWNSUN' '$ORANGEBOLDARROW' '$REDDOWN' '$REDCLOUDDOWN' '$REDUP' '$REDSMALLDOWN' '$REDSMALLUP' '$SMALLRIGHTUPYELLOW' '$TATMOS' '$TOCEAN' '$TSURF' '$UPPERTHREEWAVY' '$UPPERTWOWAVY' '$UPPERONEWAVY' '$BLUEWAVYDOTTED

#these elements are in all images
BASE=' '$SUN' '$TSURF' '$LEFTDOWNBIGSUN' '$RIGHTDOWNSUN' '$SMALLRIGHTUPYELLOW' '$BLACKHILL' '$FLATGROUND' '$REDMOUNTAINUP

convertStr=$convertStr$BASE

for ((count=1; count<=maskLen; count++))
do  
  #echo `expr substr $maskStr $count 1`
  if [ `expr substr $maskStr $count 1` -eq 1 ]; then
         #echo 'found 1 at pos '$count         
         case $count in
           1) # atmosphere
             convertStr=$convertStr' '$TATOMSQATMOS
           ;;
           2) # diffusion of heat
             convertStr=$convertStr' '$BLACKDOTTED' '$BROWNCIRCLE' '
           ;;
           3) #advection of heat
             convertStr=$convertStr' '$BLACKDOTTED' '$ORANGEBOLDARROW' '
           ;;
           4) #CO2
             convertStr=$convertStr' -page +5+40 4.png '
           ;;
           5) #oceans
             convertStr=$convertStr' '$BLUEOCEAN' '$BLUEDOTTEDOCEAN' '$TOCEAN' '
           ;;
           6) #hydrological cycle
             convertStr=$convertStr' '$CLOUD' '$REDCLOUDDOWN' '$BLUEWAVYDOTTED' '$RAINDROPS' '
           ;;
           7) #diffusion of water vapor
             convertStr=$convertStr' '$BLACKDOTTED' '$BLUECIRCLE' '
           ;;
           8) #advection of water vapor
             convertStr=$convertStr' '$BLACKDOTTED' '$BLUEBOLDARROW' '
           ;;
           9) #clouds
             convertStr=$convertStr' '$UPPERTHREEWAVY' '$REDDOWN' '$REDUP
           ;;
           10) #ice-albedo
             convertStr=$convertStr' '$ICE' '
           ;;
         esac
  fi 
done

convertStr=$convertStr' -layers flatten  mean_thumb_'$maskStr'.png'
echo $convertStr
echo `$convertStr`


#convert -size 916x652 xc:white $IMAGE -layers flatten generate_2.png
