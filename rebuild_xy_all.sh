#!/bin/bash

cd /media/temp
#wget -4 -N --show-progress "$docker_addr/d/元数据/config.mp4"
#wget -4 -N --show-progress "$docker_addr/d/元数据/pikpak.mp4"
#wget -4 -N --show-progress "$docker_addr/d/元数据/all.mp4"
aria2c -o config.mp4 --auto-file-renaming=false -c -x6 "$docker_addr/d/元数据/config.mp4"
aria2c -o pikpak.mp4 --auto-file-renaming=false -c -x6 "$docker_addr/d/元数据/pikpak.mp4"
aria2c -o all.mp4 --auto-file-renaming=false -c -x6 "$docker_addr/d/元数据/all.mp4"

cd /media
echo "执行解压............"
start_time1=`date +%s`
7z x -aoa -mmt=16 temp/config.mp4 2>/dev/null

cd /media/xiaoya
rm -rf test
7z x -aoa -mmt=16 temp/all.mp4 2>/dev/null
7z x -aoa -mmt=16 temp/pikpak.mp4 2>/dev/null

end_time1=`date +%s`
total_time1=$((end_time1 - start_time1))
total_time1=$((total_time1 / 60))
echo "解压执行时间：$total_time1 分钟"

#echo "执行替换DOCKER_ADDRESS............"
#start_time2=`date +%s`
#find ./ -name "*.strm" -exec sed \-i "s#DOCKER_ADDRESS#$docker_addr#g; s# #%20#g; s#|#%7C#g" {} \;
#fdfind --extension strm --exec sed \-i "s#DOCKER_ADDRESS#$docker_addr#g; s# #%20#g; s#|#%7C#g" {} \;
#chmod -R 777 *	
#end_time2=`date +%s`
#total_time2=$((end_time2 - start_time2))
#total_time2=$((total_time2 / 60))
#echo "替换执行时间：$total_time2 分钟"

echo -e "\033[33m"
echo "小雅元数据已经解压完成，请检查是否正常！"
echo -e "\033[0m"
