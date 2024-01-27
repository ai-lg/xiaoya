#!/bin/bash
Blue="\033[34m"
Green="\033[32m"
Red="\033[31m"
Yellow='\033[33m'
Font="\033[0m"
INFO="[${Green}INFO${Font}]"
ERROR="[${Red}ERROR${Font}]"
WARN="[${Yellow}WARN${Font}]"
clear
echo -e "\e[33m"
echo -e "—————————————————————————————————使  用  说  明———————————————————————————————————"
echo -e "1、本脚本为小雅EMBY全家桶的定制化安装脚本，使用于群晖系统环境，不保证其他系统通用；"
echo -e "\n"
echo -e "2、本脚本为个人自用，不维护，不更新，不保证适用每个人的环境，请勿用于商业用途；"
echo -e "\n"
echo -e "3、作者不对使用本脚本造成的任何后果负责，有任何顾虑，请勿运行脚本，按CTRL+C立即退出；"
echo -e "\n"
echo -e "4、如果您喜欢这个脚本，可以请我喝咖啡："
echo -e "——————————————————————————————————————————————————————————————————————————————————"
echo -e "\e[0m"

# 定义函数
function0() {
	clear
    echo -e "\n"
    echo -e "———————————————————————————————————————————————————— \033[1;33m老  G  提  醒\033[0m —————————————————————————————————————————————————"
    echo -e "\033[1;37m"
    echo -e "1、mytoken.txt（运行小雅ALIST必需）"
	echo -e "2、myopentoken.txt（运行小雅ALIST必需）"
	echo -e "3、temp_transfer_folder_id.txt（运行小雅ALIST必需"
	echo -e "4、docker_address.txt（小雅ALIST访问地址）"
	echo -e "5、emby_server.txt（2345端口代理的EMBY访问地址）"
    echo -e "\n"
	echo -e "6、guestpass.txt（网页/WebDav登陆密码）"
	echo -e "7、guestlogin.txt（空白文件，web页登陆强制认证需要有此文件）"
	echo -e "8、show_my_ali.txt（空白文件，加载自己的阿里云盘需创建此文件）"
	echo -e "9、alist_token_expire_time.txt（设置alist auth token的有效期，缺省4800，单位：小时）"
	echo -e "10、alist_list.txt（挂载一个或多个 Alist 套娃）\033[0m"
	echo -e "\n"
	echo -e "11、alishare_list.txt（挂载自定义分享ID）\033[0m"
	echo -e "12、pikpakshare_list.txt（挂载自己一个或多个 pikpak分享）"
	echo -e "13、pikpak_list.txt（挂载自己一个或多个 pikpak账号）"
	echo -e "14、pikpak.txt（用来观看pikpak分享）\033[0m"
	echo -e "15、proxy.txt（使用代理，http，https，socks5 协议）"
    echo -e "\n"
	echo -e "16、docker_address_ext.txt（外网地址，配合tvbox外网访问）"
	echo -e "17、iptv.m3u（在my.json中自定义额外的直播源 "我的私用"）"
	echo -e "18、tv.txt（挂载自定义直播源到xiaoya）\033[0m"
	echo -e "19、tvbox_security.txt（开启tvbox的随机订阅地址，防止公网上被人蹭）"
	echo -e "20、my.json（自定义tvbox配置文件）"
	echo -e "\033[0m"
    echo -e "\033[1;32m小雅配置说明：https://xiaoyaliu.notion.site/xiaoya-docker-69404af849504fa5bcf9f2dd5ecaa75f\033[0m"
    echo -e "\033[1;35m获取mytoken链接：https://aliyuntoken.vercel.app\033[0m"
    echo -e "\033[1;32m获取myopentoken链接：https://alist.nn.ci/zh/guide/drivers/aliyundrive_open.html\033[0m"
    echo -e "\033[1;35m获取阿里云盘转存目录id链接：https://www.aliyundrive.com/s/rP9gP3h9asE\033[0m"
	echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
	echo -e "\n"
}

function7() {
    if [[ $f3_select_0 -ge 1 && $f3_select_0 -le 20 ]]; then
        # 定义一个数组，包含所有的文件名
        files=("mytoken.txt" "myopentoken.txt" "temp_transfer_folder_id.txt" "docker_address.txt" "emby_server.txt" "guestpass.txt" "guestlogin.txt" "show_my_ali.txt" "alist_token_expire_time.txt" "alist_list.txt" "alishare_list.txt" "pikpakshare_list.txt" "pikpak_list.txt" "pikpak.txt" "proxy.txt" "docker_address_ext.txt" "iptv.m3u" "tv.txt" "tvbox_security.txt" "my.json")

        # 获取用户选择的文件名
        file=${files[$((f3_select_0-1))]}

        echo -e "\033[1;32m你选择了文件：$file\033[0m"
        echo -e "\033[1;32m请选择操作：\033[0m"
        echo -e "\033[1;35m1、修改/创建文件；	2、删除文件;\033[0m"
        read operation

        # 检查用户选择的操作
        if [[ $operation -eq 1 ]]; then
            # 修改/创建文件
            if [[ -f "$config_dir/$file" ]]; then
		        echo "当前的内容为："
		        cat "$config_dir/$file"
	    	else
	    		touch "$config_dir/$file"
		    fi
		    echo "请输入新的内容（如果想保持原内容不变，直接按回车）："
		    read content
		    if [[ -n $content ]]; then
		        echo $content > "$config_dir/$file"
		        echo "文件已更新。"
		    else
		        echo "文件内容保持不变。"
		    fi
        elif [[ $operation -eq 2 ]]; then
            # 删除文件
            echo "你确定要删除文件吗？(y/n)"
            read confirm
            if [[ $confirm == [Yy] ]]; then
                rm $config_dir/$file
            fi
        else
            echo "无效的操作，程序退出。"
            exit 1
        fi
    elif [[ $f3_select_0 == [Qq] ]]; then
    	exit 0
    else
        echo "无效的序号，程序退出。"
    fi
}

function1() {
    clear
    echo -e "———————————————————————————————————————————————————— \033[1;33m老  G  提  醒\033[0m —————————————————————————————————————————————————"
    echo -e "\n"
    echo -e "A、新版小雅ALIST默认使用xiaoya容器名，为避免端口冲突，执行安装前请停止或删除原来的小雅ALIST容器；"
    echo -e "\n"
    echo -e "B、新版小雅ALIST使用6908作为小雅EMBY的默认端口，不使用小雅全家桶一键安装EMBY想自定义端口的可退出重新运行选择定制安装；"
    echo -e "\n"
    echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
    echo -e "\n"
    echo -e "\033[1;32m1、小雅ALIST全新安装（保留token等配置文件进行重装请选此项）\033[0m"
    echo -e "\n"
	echo -e "\033[1;35m2、小雅ALIST清除原有token等配置文件重装安装\033[0m"
	echo -e "\n"
	echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
    read -ep "请输入您的选择（1或2或3）；" f1_select
    
    if [[ $f1_select == 1 ]]; then
	    read -ep "是否选择host模式安装？(Y/N)" host_select
	    if [[ $host_select == [Yy] ]]; then
	        bash -c "$(curl http://docker.xiaoya.pro/update_new.sh)" -s host
	        status=$?
		    if [[ $status -eq 0 ]]; then
		        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
		    else
		        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是否没删除其他安装的小雅ALIST！\033[0m"
		    fi
	        exit
	    elif [[ $host_select == [Nn] ]]; then
	        bash -c "$(curl http://docker.xiaoya.pro/update_new.sh)"
	        status=$?
		    if [[ $status -eq 0 ]]; then
		        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
		    else
		        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是否没删除其他安装的小雅ALIST！\033[0m"
		    fi
	        exit
	    else
	        echo "输入错误，程序将退出"
	        exit 1
	    fi
	elif [[ $f1_select == 2 ]]; then
		rm -rf /etc/xiaoya/*
		read -ep "是否选择host模式安装？(Y/N)" host_select
	    if [[ $host_select == [Yy] ]]; then
	        bash -c "$(curl http://docker.xiaoya.pro/update_new.sh)" -s host
	        status=$?
		    if [[ $status -eq 0 ]]; then
		        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
		    else
		        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是否没删除其他安装的小雅ALIST！\033[0m"
		    fi
	        exit
	    elif [[ $host_select == [Nn] ]]; then
	        bash -c "$(curl http://docker.xiaoya.pro/update_new.sh)"
	        status=$?
		    if [[ $status -eq 0 ]]; then
		        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
		    else
		        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是否没删除其他安装的小雅ALIST！\033[0m"
		    fi
	        exit
	    else
	        echo "输入错误，程序将退出"
	        exit 1
	    fi
    else
    	echo "输入错误，程序将退出"
        exit 1
	fi
}

function2() {
	clear
    echo -e "\n"
    echo -e "———————————————————————————————————————————————————— \033[1;33m老  G  提  醒\033[0m —————————————————————————————————————————————————"
    echo -e "\n"
    while true; do
        echo -e "\033[1;35m请输入您的小雅ALIST配置文件路径:\033[0m"
        read path
        echo -e "\n"
        if [ -d "$path" ]; then
            echo -e "\033[1;37m您选择的小雅ALIST配置文件路径是: \033[1;35m$path\033[0m"
            echo -e "\n"
            read -ep "确认就按Y/y：" f2_select
            if [[ $f2_select == [Yy] ]]; then
            	break
            fi
        else
            echo "路径不存在"
            echo -e "\n"
            echo -e "\033[1;31m你确定要选择这个目录吗？(y/n): \033[0m"
            read yn
            case $yn in
                [Yy]* ) break;;
                [Nn]* ) continue;;
                * ) echo "请输入y或n";;
            esac
        fi
    done

    #while true; do
        echo -e "\n"
        echo -e "\033[1;35m选择host模式安装请输入host后回按车，选择非host模式请直接按回车）:\033[0m"
        read str
        echo -e "\n"
        if [[ -z "$str" ]]; then
            echo -e "\033[1;35m如果安装多个小雅alist，请注意避开端口冲突：\033[0m"
	    	read -ep "请输入映射到容器80的宿主机端口：" port_1
			read -ep "请输入映射到容器2345的宿主机端口：" port_2
			read -ep "请输入映射到容器2346的宿主机端口：" port_3
			curl -o $path/update_new.sh https://raw.githubusercontent.com/ai-lg/xiaoya/main/update_new.sh
			sed -i "s#5678#$port_1#g;s#2345:2345#$port_2:2345#g;s#2346:2346#$port_3:2346#g" $path/update_new.sh
			read -p "是否安装多个小雅Alist? “是”按Y，“不是”按任意键。 " multi
			( ! [[ -z $(docker ps | grep -P "xiaoyaliu\/alist.*xiaoya$") ]] || [[ $multi == [Yy] ]] )&& sed -i "s#--name=xiaoya#--name=xiaoya-da#g" $path/update_new.sh
			bash -c "$(cat $path/update_new.sh)" -s $path $str
        elif [[ "$str" == "host"  ]]; then
            bash -c "$(curl https://raw.githubusercontent.com/ai-lg/xiaoya/main/update_new.sh)" -s $path $str
            
        else
        	echo "\033[1;31m输入错误，请任意键重新输入或按q退出\033[0m"
            echo -e "\n"
            read f2_select_0
            if [[ $f2_select_0 == [Qq] ]]; then
            	exit
            fi
            function2 0
        fi
    #done
    	
    status=$?
    if [[ $status -eq 0 ]]; then
        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
    else
        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是否没删除其他安装的小雅ALIST！\033[0m"
    fi
    exit
}


function3() {
	clear
    echo -e "\n"
    echo -e "———————————————————————————————————————————————————— \033[1;33m老  G  提  醒\033[0m —————————————————————————————————————————————————"
    echo -e "\n"
	docker_name=$(docker ps -a | grep xiaoyaliu/alist | awk '{print $NF}')
	config_dir=$(docker inspect $docker_name | jq -r '.[].Mounts[] | select(.Destination=="/data") | .Source')
	echo -e "\033[1;37m找到您的小雅ALIST配置文件路径是: \033[1;35m\n$config_dir\033[0m"
    echo -e "\n"
    read -ep "确认就按Y/y，或者按N/n手动输入路径（注：上方显示多个路径也请选择手动输入）：" f3_select
    if [[ $f3_select == [Yy] ]]; then
    	while true; do
	    	function0
			echo -e "\033[1;35m请选择你需要修改的文件（如不存在则会创建）或按q键退出：\033[0m"
			read f3_select_0
			function7
		done
	elif [[ $f3_select == [Nn] ]]; then
		echo -e "\033[1;35m请输入您的小雅ALIST配置文件路径:\033[0m"
        read config_dir
        echo -e "\n"
        if [[ -d "$config_dir" && -f "$config_dir/mytoken.txt" ]]; then
            echo -e "\033[1;37m您选择的小雅ALIST配置文件路径是: \033[1;35m$config_dir\033[0m"
            echo -e "\n"
            read -ep "确认就按Y/y：" f3_select_1
            if [[ $f3_select_1 == [Yy] ]]; then
            	while true; do
	            	function0
	            	echo -e "\033[1;35m请选择你需要修改的文件（如不存在则会创建）或按q键退出：\033[0m"
					read f3_select_0
					function7
				done
			else
				echo "选择错误，程序将退出。"
            	exit 1
            fi
        else
            echo "该路径不存在或该路径下没有mytoken.txt配置文件"
            echo -e "\n"
            echo -e "\033[1;31m你确定要选择这个目录吗？(y/n): \033[0m"
            read yn
            case $yn in
                [Yy]* ) 
                	mkdir -p $config_dir
                	while true; do
                	function0
		            	echo -e "\033[1;35m请选择你需要修改的文件（如不存在则会创建）或按q键退出：\033[0m"
						read f3_select_0
						function7
					done
                	;;
                [Nn]* ) 
                	echo -e "路径选择有误，客户退出程序"
                	exit 1
                	;;
                * ) 
                	echo "选择错误，程序将退出。"
                	exit 1
                	;;
            esac
        fi
    else
    	echo "选择错误，程序将退出。"
    	exit 1
    fi
}

function8() {
	echo -e "————————————————————————————————————————————————————— \033[1;33mA  I  老  G\033[0m ——————————————————————————————————————————————————"
    echo -e "\n"
    echo -e "\033[1;32m1、config.mp4 —— 小雅emby的配置目录数据\033[0m"
    echo -e "\n"
    echo -e "\033[1;35m2、all.mp4 —— 除pikpak之外的所有小雅元数据\033[0m"
    echo -e "\n"
    echo -e "\033[1;32m3、pikpak.mp4 —— pikpak元数据（需魔法才能观看）\033[0m"
    echo -e "\n"
    echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
    echo -e "请选择您\033[1;31m不需要安装\033[0m的元数据(输入序号，多项用逗号分隔）："
    read f8_select
	if ! [[ $f8_select =~ ^[1-3]([\,\，][1-3])*$ ]]; then
        echo "输入的序号无效，请输入1到3之间的数字。"
        exit 1
    fi

    files=("config.mp4" "all.mp4" "pikpak.mp4")
    curl -o $media_dir/update_metainfo.plus.sh http://docker.xiaoya.pro/update_metainfo.plus.sh
    for index in $(echo $f8_select | tr "," "\n")
    do
        file=${files[$index-1]}
        sed -i "/aria2c.*$file/d" $media_dir/update_metainfo.plus.sh
        sed -i "/7z.*$file/d" $media_dir/update_metainfo.plus.sh
    done
    awk '/if \[ "\$2" == "all" \]; then/{flag=1;next} /^fi/ && flag {next;flag=0} 1' $media_dir/update_metainfo.plus.sh > $media_dir/temp.sh && mv $media_dir/temp.sh $media_dir/update_metainfo.plus.sh
    sed -i "s|/update_all.sh|/media/update_metainfo.plus.sh|" $config_dir/emby.sh
    chmod 777 $media_dir/update_metainfo.plus.sh
}

function10() {
	if [[ $happy == [Yy] ]]; then
		sed -i "s#emby/embyserver#amilys/embyserver#g" $config_dir/emby.sh
		sed -i '/docker run -d --name emby/s#--user 0:0#--privileged --user 0:0 --device=/dev/dri#g' $config_dir/emby.sh
		
	fi
	if ! [[ $all == [Yy] ]]; then
		function8
	fi
}

function9() {
	read -ep "请输入您的小雅媒体库安装路径：" media_dir
    docker_name=$(docker ps -a | grep xiaoyaliu/alist | awk '{print $NF}')
	config_dir=$(docker inspect $docker_name | jq -r '.[].Mounts[] | select(.Destination=="/data") | .Source')
	echo -e "\033[1;37m找到您的小雅ALIST配置文件路径是: \033[1;35m\n$config_dir\033[0m"
    echo -e "\n"
    read -ep "确认请按任意键，或者按N/n手动输入路径（注：上方显示多个路径也请选择手动输入）：" f4_select_0
    if [[ $f4_select_0 == [Nn] ]]; then
		echo -e "\033[1;35m请输入您的小雅ALIST配置文件路径:\033[0m"
        read config_dir
        echo -e "\n"
        if [[ -d "$config_dir" && -f "$config_dir/mytoken.txt" ]]; then
            echo -e "\033[1;37m您选择的小雅ALIST配置文件路径是: \033[1;35m$config_dir\033[0m"
            echo -e "\n"
            read -ep "确认就按Y/y：" f4_select_1
            if ! [[ $f4_select_1 == [Yy] ]]; then
				echo "选择错误，程序将退出。"
            	exit 1
            fi
        else
            echo "该路径不存在或该路径下没有mytoken.txt配置文件"
            echo -e "\n"
            echo -e "\033[1;31m您选择的个目录不正确，程序退出。\033[0m"
            exit 1
        fi
    fi
    echo -e "\033[1;37m是否要更改EMBY的访问端口？（小雅默认6908，无特殊需求，不建议更改）\033[0m"
    echo -e "\n"
    read -ep "请输入您要更改的端口号（不要与别的容器冲突），不更改请直接按回车！" f4_select_2
    if [[ -z "$f4_select_2" ]]; then
    	read -ep "是否选择host模式安装？(Y/N)" host_select
    	if [[ $host_select == [Yy] ]]; then
    		curl -o $config_dir/emby.sh http://docker.xiaoya.pro/emby.sh
    		function10
    		sed -i "s#\$1#/media#g" $media_dir/update_metainfo.plus.sh
    		localip=$(ip -4 addr show | grep inet | grep -v 127.0.0.1 | grep -v 172. | awk '{print $2}' | cut -d'/' -f1)
    		sed -i "s#127.0.0.1#$localip#g" $config_dir/emby.sh
    		sed -i "s#http://\$docker0#$http://localip#g" $config_dir/emby.sh
	    	bash -c "$(cat $config_dir/emby.sh)" -s $media_dir $config_dir
   			sleep 3
	    	status=$?
		    if [[ $status -eq 0 ]]; then
		        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
		    else
		        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是不是端口冲突了！\033[0m"
		    fi
		    #rm -f $config_dir/emby.sh
		    chmod 777 $media_dir
	        exit
	    else
	    	read -ep "请输入映射到容器6908的宿主机端口：" port_1
	    	read -ep "请输入映射到容器8920的宿主机端口：" port_2
	    	read -ep "请输入映射到容器1900的宿主机端口：" port_3
	    	read -ep "请输入映射到容器7359的宿主机端口：" port_4
	    	curl -o $config_dir/emby.sh http://docker.xiaoya.pro/emby.sh
		    sed -i "s/--network=host/-p $port_1:6908 -p $port_2:8920 -p $port_3:1900\/udp -p $port_4:7359\/udp/g" $config_dir/emby.sh
		    function10
	    	sed -i "s#\$1#/media#g" $media_dir/update_metainfo.plus.sh
	    	localip=$(ip -4 addr show | grep inet | grep -v 127.0.0.1 | grep -v 172. | awk '{print $2}' | cut -d'/' -f1)
    		sed -i "s#127.0.0.1#$localip#g" $config_dir/emby.sh
    		sed -i "s#http://\$docker0#$http://localip#g" $config_dir/emby.sh
	    	bash -c "$(cat $config_dir/emby.sh)" -s $media_dir $config_dir
	    	sleep 3
		    status=$?
		    if [[ $status -eq 0 ]]; then
		        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
		    else
		        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是不是端口冲突了！\033[0m"
		    fi
		    #rm -f $config_dir/emby.sh
	        chmod 777 $media_dir
	        exit
        fi
	elif [[ $f4_select_2 =~ ^[1-9][0-9]*$ ]] && [ $f4_select_2 -ge 1 ] && [ $f4_select_2 -le 65535 ]; then
	    read -ep "是否选择host模式安装？(Y/N)" host_select
	    if [[ $host_select == [Yy] ]]; then
		    curl -o $config_dir/emby.sh http://docker.xiaoya.pro/emby.sh
		    sed -i "s/6908/$f4_select_2/g" $config_dir/emby.sh
		    function10
		    sed -i "s#\$1#/media#g" $media_dir/update_metainfo.plus.sh
		    localip=$(ip -4 addr show | grep inet | grep -v 127.0.0.1 | grep -v 172. | awk '{print $2}' | cut -d'/' -f1)
    		sed -i "s#127.0.0.1#$localip#g" $config_dir/emby.sh
    		sed -i "s#http://\$docker0#$http://localip#g" $config_dir/emby.sh
		    bash -c "$(cat $config_dir/emby.sh)" -s $media_dir $config_dir
		    docker stop emby
			sleep 5
		    sed -i "s/6908/$f4_select_2/g" $media_dir/config/config/system.xml
		    docker start emby
		    status=$?
		    if [[ $status -eq 0 ]]; then
		        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
		    else
		        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是不是端口冲突了！\033[0m"
		    fi
		    #rm -f $config_dir/emby.sh
		    chmod 777 $media_dir
	        exit
		else
			echo -e "请输入映射到容器$f4_select_2的宿主机端口："
			read port_1
	    	read -ep "请输入映射到容器8920的宿主机端口：" port_2
	    	read -ep "请输入映射到容器1900的宿主机端口：" port_3
	    	read -ep "请输入映射到容器7359的宿主机端口：" port_4
	    	curl -o $config_dir/emby.sh http://docker.xiaoya.pro/emby.sh
	    	sed -i "s/6908/$f4_select_2/g" $config_dir/emby.sh
		    sed -i "s/--network=host/-p $port_1:$f4_select_2 -p $port_2:8920 -p $port_3:1900\/udp -p $port_4:7359\/udp/g" $config_dir/emby.sh
		    function10
		    sed -i "s#\$1#/media#g" $media_dir/update_metainfo.plus.sh
		    localip=$(ip -4 addr show | grep inet | grep -v 127.0.0.1 | grep -v 172. | awk '{print $2}' | cut -d'/' -f1)
    		sed -i "s#127.0.0.1#$localip#g" $config_dir/emby.sh
    		sed -i "s#http://\$docker0#$http://localip#g" $config_dir/emby.sh
		    bash -c "$(cat $config_dir/emby.sh)" -s $media_dir $config_dir
			docker stop emby
			sleep 5
		    sed -i "s/6908/$f4_select_2/g" $media_dir/config/config/system.xml
		    docker start emby
		    if [[ $status -eq 0 ]]; then
		        echo -e "\033[1;35m哇塞！安装完成了，快去看看吧！\033[0m"
		    else
		        echo -e "\033[1;31m哎呀！安装出错了，错误代码：$status。检查是不是端口冲突了！\033[0m"
		    fi
		    #rm -f $config_dir/emby.sh
		    chmod 777 $media_dir
	        exit
        fi
    else
    	echo "输入的端口号无效，请输入1到65535之间的正整数。"
	    exit 1
	fi
}
    
function4() {
    clear
	echo -e "\n"
    echo -e "————————————————————————————————————————————————————— \033[1;33mA  I  老  G\033[0m ——————————————————————————————————————————————————"
    echo -e "\n"
    echo -e "\033[1;32m1、完整安装小雅EMBY全家桶开心版\033[0m"
    echo -e "\n"
    echo -e "\033[1;35m2、选择性安装小雅EMBY全家桶开心版\033[0m"
    echo -e "\n"
    echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
    read -ep "请输入您的选择（1或2）；" f4_select
    if [[ $f4_select == 1 ]]; then
    	all="y"
    	happy="y"
    	function9
    elif [[ $f4_select == 2 ]]; then
    	all="n"
    	happy="y"
    	function9
    else
    	echo "输入错误，程序将退出"
        exit 1
    fi
}

function5() {
    clear
	echo -e "\n"
    echo -e "————————————————————————————————————————————————————— \033[1;33mA  I  老  G\033[0m ——————————————————————————————————————————————————"
    echo -e "\n"
    echo -e "\033[1;32m1、完整安装小雅EMBY全家桶官方版\033[0m"
    echo -e "\n"
    echo -e "\033[1;35m2、选择性安装小雅EMBY全家桶官方版\033[0m"
    echo -e "\n"
    echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
    read -ep "请输入您的选择（1或2）；" f5_select
    if [[ $f5_select == 1 ]]; then
    	all="y"
    	happy="n"
    	function9
    elif [[ $f5_select == 2 ]]; then
    	all="n"
    	happy="n"
    	function9
	else
    	echo "输入错误，程序将退出"
        exit 1
    fi
}

function6() {
    clear
	echo -e "\n"
    echo -e "————————————————————————————————————————————————————— \033[1;33mA  I  老  G\033[0m ——————————————————————————————————————————————————"
    echo -e "\n"
    echo -e "\033[1;32m1、安装小雅媒体库\033[0m"
    echo -e "\n"
    echo -e "\033[1;35m2、维护小雅媒体库\033[0m"
    echo -e "\n"
    echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
    read -ep "请输入您的选择（1或2）；" f6_select
    if [[ $f6_select == 1 ]]; then
    	read -ep "请输入您的小雅媒体库安装路径：" media_dir
	    docker_name=$(docker ps -a | grep xiaoyaliu/alist | awk '{print $NF}')
		config_dir=$(docker inspect $docker_name | jq -r '.[].Mounts[] | select(.Destination=="/data") | .Source')
		echo -e "\033[1;37m找到您的小雅ALIST配置文件路径是: \033[1;35m\n$config_dir\033[0m"
	    echo -e "\n"
	    read -ep "确认请按任意键，或者按N/n手动输入路径（注：上方显示多个路径也请选择手动输入）：" f6_select_0
	    if [[ $f6_select_0 == [Nn] ]]; then
			echo -e "\033[1;35m请输入您的小雅ALIST配置文件路径:\033[0m"
	        read config_dir
	        echo -e "\n"
	        if [[ -d "$config_dir" && -f "$config_dir/mytoken.txt" ]]; then
	            echo -e "\033[1;37m您选择的小雅ALIST配置文件路径是: \033[1;35m$config_dir\033[0m"
	            echo -e "\n"
	            read -ep "确认就按Y/y：" f6_select_1
	            if ! [[ $f6_select_1 == [Yy] ]]; then
					echo "选择错误，程序将退出。"
	            	exit 1
	            fi
	        else
	            echo "该路径不存在或该路径下没有mytoken.txt配置文件"
	            echo -e "\n"
	            echo -e "\033[1;31m您选择的个目录不正确，程序退出。\033[0m"
	            exit 1
	        fi
	    fi
	    echo -e "\n"
	    echo -e "————————————————————————————————————————————————————— \033[1;33mA  I  老  G\033[0m ——————————————————————————————————————————————————"
	    echo -e "\n"
	    echo -e "\033[1;32m1、完整安装小雅媒体库\033[0m"
	    echo -e "\n"
	    echo -e "\033[1;35m2、选择性安装小雅媒体库\033[0m"
	    echo -e "\n"
	    echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
	    read -ep "请输入您的选择（1或2）；" f6_select_2
	    if [[ $f6_select_2 == 1 ]]; then
	    	docker run -it --security-opt seccomp=unconfined --rm --net=host -v $media_dir:/media -v $config_dir:/etc/xiaoya -e LANG=C.UTF-8  xiaoyaliu/glue:latest /update_all.sh
    	elif [[ $f6_select_2 == 2 ]]; then
    		curl -o $config_dir/emby.sh http://docker.xiaoya.pro/emby.sh
    		mkdir -p $media_dir/temp
    		mkdir -p $media_dir/config
    		mkdir -p $media_dir/xiaoya
    		function8
    		sed -i "s#\$1#/media#g" $media_dir/update_metainfo.plus.sh
    		#sed -i "s#/etc/xiaoya#$config_dir#g" $media_dir/update_metainfo.plus.sh
    		docker run -it --security-opt seccomp=unconfined --rm --net=host -v $media_dir:/media -v $config_dir:/etc/xiaoya -e LANG=C.UTF-8  xiaoyaliu/glue:latest /media/update_metainfo.plus.sh
    		rm -f $media_dir/update_metainfo.plus.sh
    		rm -f $config_dir/emby.sh
    	else
    		echo "输入错误，程序将退出。"
        	exit 1
        fi
	elif [[ $f6_select == 2 ]]; then
		echo -e "\n"
	    echo -e "————————————————————————————————————————————————————— \033[1;33mA  I  老  G\033[0m ——————————————————————————————————————————————————"
	    echo -e "\n"
	    echo -e "\033[1;32m1、重装小雅媒体库config\033[0m"
	    echo -e "\n"
	    echo -e "\033[1;35m2、元数据自定义解压（按需选择all中的部分元数据）\033[0m"
	    echo -e "\n"
	    echo -e "\033[1;35m3、获取小雅ALIST反代日志，查看是否直链播放成功\033[0m"
	    echo -e "\n"
	    echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
    	read -ep "请输入您的选择（1-4）；" f6_select_3
	    if [[ $f6_select_3 == 1 ]]; then
	    	echo -e "小雅媒体库路径下应有temp\config\xiaoya三个文件夹，如“/volume1/docker/xiaoya/config”，只需输入“/volume1/docker/xiaoya”（不含双引号）"
	    	read -ep "所以您要重装config的小雅媒体库安装路径是：" media_dir
			
	    	echo -e "\033[1;32m是否需要保留用户数据？\033[0m"
	    	read -ep "是（按任意键）/否（N）" f6_select_5
	    	if ! [[ $f6_select_5 == [Nn] ]]; then
	    		echo -e "请填写使用该config的emby访问地址，示例：http://192.168.3.3:8096" 
	    		read -ep "您的地址是：" EMBY_URL
		    	GET_EMBY_API=$(sqlite3 $media_dir/config/data/authentication.db "SELECT AccessToken FROM Tokens_2 WHERE AppName = 'xiaoya';")
		    	echo -e "获取到该emby的API_KEY为 \033[1;35m$GET_EMBY_API\033[0m"
		    	read -ep "按回车确认或手动输入您的API_KEY："  EMBY_API
		    	[[ -z $EMBY_API ]] && EMBY_API=$GET_EMBY_API
		    	
	    		emby_name=$(docker ps -a --format '{{.Names}}' | while read container; do
				    if docker inspect "$container" | grep -q "$media_dir/xiaoya:/media"; then
				        echo "$container"
				        break
				    fi
				done)

				docker stop $emby_name
	    		mkdir -p $media_dir/temp/bak
	    		mkdir -p $media_dir/temp/bak/users
	    		cp -rf $media_dir/config/config/users/* $media_dir/temp/bak/users/
	    		cp -f $media_dir/config/data/users.db* $media_dir/temp/bak
	    		sqlite3 $media_dir/config/data/library.db ".dump UserDatas" > $media_dir/temp/xiaoya_emby_library_user.sql
	    		chmod 777 $media_dir/temp/xiaoya_emby_library_user.sql

	    	fi

			docker_names=$(docker ps -a | grep xiaoyaliu/alist | awk '{print $NF}')
			index=1
			#获取所有config目录
			declare -a docker_dirs
			for docker_name in $docker_names
			do
			    config_dir=$(docker inspect $docker_name | jq -r '.[].Mounts[] | select(.Destination=="/data") | .Source')		
			    if [ -f "$config_dir/docker_address.txt" ] && [ -s "$config_dir/docker_address.txt" ]
			    then
			        # 如果文件存在且内容非空，就打印出文件的路径和内容
			        echo "$index.在$config_dir/docker_address.txt找到小雅alist访问地址：$(cat $config_dir/docker_address.txt)"
			        # 将config_dir添加到数组中
			        docker_dirs[$index]=$(cat $config_dir/docker_address.txt)
			        ((index++))
			    fi
			done
			
			# 提示用户输入序号
			read -p "请输入正确小雅alist访问地址的序号或按N/n手动输入：" f6_select_4
			
			[[ $f6_select_4 == [Nn] ]] && read -ep "参考示例：http://192.168.8.8:5678 输入您的小雅ALIST访问地址：" docker_addr

			docker_addr=${docker_dirs[$f6_select_4]}
			
			
	    	curl -o $media_dir/rebuild_xy_config.sh https://raw.githubusercontent.com/ai-lg/xiaoya/main/rebuild_xy_config.sh
	    	sed -i "s#\$docker_addr#$docker_addr#g" $media_dir/rebuild_xy_config.sh
	    	chmod 777 $media_dir/rebuild_xy_config.sh

	    	docker run -it --security-opt seccomp=unconfined --rm --net=host -v $media_dir:/media -e LANG=C.UTF-8  xiaoyaliu/glue:latest /media/rebuild_xy_config.sh
	    	#docker start $emby_name
	    	#sleep 10
	    	
	    	if ! [[ $f6_select_5 == [Nn] ]]; then
	    		cp -rf $media_dir/temp/bak/users/* $media_dir/config/config/users/
	    		cp -f $media_dir/temp/bak/users.db* $media_dir/config/data/

	    		sqlite3 $media_dir/config/data/library.db "DROP TABLE IF EXISTS UserDatas;"
	    		sqlite3 $media_dir/config/data/library.db ".read $media_dir/temp/xiaoya_emby_library_user.sql"
				chmod 777 $media_dir/config/data/library.db*

	    		docker start $emby_name
	    		sleep 10
	    		
	    		USER_URL="${EMBY_URL}/Users?api_key=${EMBY_API}"  
			    response=$(curl -s "$USER_URL")
			    
			    USER_COUNT=$(echo "$response" | jq '. | length')
			    
			    for((i=0;i<$USER_COUNT;i++))  
			    do
			        read -r name <<< "$(echo "$response" | jq -r ".[$i].Name")"  
			        read -r id <<< "$(echo "$response" | jq -r ".[$i].Id")"
			        read -r policy <<< "$(echo "$response" | jq -r ".[$i].Policy | to_entries | from_entries | tojson")"

					USER_URL_2="${EMBY_URL}/Users/$id/Policy?api_key=${EMBY_API}"

					curl -i -H "Content-Type: application/json" -X POST -d "$policy" "$USER_URL_2"
					echo -e "【$name】"用户策略更新成功！

			    done
			    				
				echo -e "所有用户策略更新成功！"
			fi
			
			docker restart $emby_name
			#rm -rf $media_dir/temp/bak
			#rm -f $media_dir/temp/xiaoya_emby_library_user.sql
	    		
		elif [[ $f6_select_3 == 2 ]]; then
			echo -e "小雅媒体库路径下应有temp\config\xiaoya三个文件夹，如“/volume1/docker/xiaoya/config”，只需输入“/volume1/docker/xiaoya”（不含双引号）"
	    	read -ep "所以您要重装config的小雅媒体库安装路径是：" media_dir
	    	cd $media_dir
	    	7z l ./temp/all.mp4 | awk -F'/' '{ print $1 }' | awk '{print $5}' | grep -vP '^[ \-(0-9a-zA-Z]' | sort | uniq > output.txt
			sed -i '/^$/d' output.txt
			
			# 逐行读取每一行内容
			declare -a arr
			i=1
			while IFS= read -r line
			do
			    echo "$i. $line"
			    arr[i]=$line
			    ((i++))
			done < output.txt
			
			while true; do
			    echo "请输入你想要解压的文件夹的编号，多个编号用逗号分隔："
			    read input
			
			    # 检查用户输入
			    IFS=',，' read -ra ADDR <<< "$input"
			    valid=true
			    for index in "${ADDR[@]}"; do
			        if ! [[ "$index" =~ ^[0-9]+$ ]] || [ "$index" -lt 1 ] || [ "$index" -gt ${#arr[@]} ]; then
			            echo "输入的编号 $index 是非法的，请重新输入。"
			            valid=false
			            break
			        fi
			    done
				
				# 选择存放目录并解压
			    if $valid; then
			        echo -e "请输入您存放解压元数据存放的目录，存放在默认的$media_dir/xiaoya请直接按回车"
		            read f6_select_3
			        for index in "${ADDR[@]}"; do
			            if [[ -z $f6_select_3 ]];then
			            	echo "正在解压：${arr[$index]}"
			            	7z x -aoa -mmt=16 ./temp/all.mp4 "${arr[$index]}/*" -o./xiaoya
			            else
			            	echo "正在解压：${arr[$index]}"
			            	7z x -aoa -mmt=16 ./temp/all.mp4 "${arr[$index]}/*" -o$f6_select_3
			            fi
			        done
			        break
			    fi
			done
		elif [[ $f6_select_3 == 3 ]]; then
			
			docker_names=($(docker ps | grep xiaoyaliu/alist | awk '{print $NF}'))
			echo "找到以下匹配的docker容器："
			for i in "${!docker_names[@]}"; do
			  echo "$((i+1)). ${docker_names[i]}"
			done
			
			read -p "请输入你想操作的docker容器的编号：" choice
			docker_name=${docker_names[$((choice-1))]}
			
			config_dir=$(docker inspect $docker_name | jq -r '.[].Mounts[] | select(.Destination=="/data") | .Source')
			docker exec $docker_name bash -c "mkdir -p /data/log && cp -f /var/log/nginx/error.log /data/log"
			echo -e "日志文件已存入您当前运行的小雅ALIST配置目录，请在log子目录中查看！"
		else
			echo "输入错误，程序将退出。"
    		exit 1
    	fi
		
    else
    	echo "输入错误，程序将退出。"
    	exit 1
    fi
}


while true; do
	clear
	echo -e "\n"
    echo -e "————————————————————————————————————————————————————— \033[1;33mA  I  老  G\033[0m ——————————————————————————————————————————————————"
    echo -e "\n"
    echo -e "\033[1;32m1、安装/维护小雅ALIST\033[0m"
    echo -e "\n"
    echo -e "\033[1;35m2、安装/维护小雅EMBY\033[0m"
    echo -e "\n"
    echo -e "\033[1;32m3、自定义安装EMBY\033[0m"
    echo -e "\n"
    echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
    read -ep "请输入您的选择（1-3）；" user_select

    if [[ $user_select == 1 ]]; then
    	echo -e "————————————————————————————————————————————————————— \033[1;33mA  I  老  G\033[0m ——————————————————————————————————————————————————"
    	echo -e "\n"
    	echo -e "1、小雅ALIST\033[1;32m原版安装/重装\033[0m"
        echo -e "\n"
		echo -e "2、小雅ALIST\033[1;35m定制安装/重装\033[0m"
		echo -e "\n"
		echo -e "3、修改小雅ALIST\033[1;36m配置文件\033[0m"
		echo -e "\n"
		echo -e "————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
		read -ep "请输入您的选择（1，2或3）；" ALIST_select
        if [[ $ALIST_select == 1 ]]; then
            function1
        elif [[ $ALIST_select == 2 ]]; then
            function2
        elif [[ $ALIST_select == 3 ]]; then
            function3
        else
            echo "输入错误，程序将退出"
            exit 1
        fi
        break
    elif [[ $user_select == 2 ]]; then
    	echo -e "————————————————————————————————— \033[1;33mA  I  老  G\033[0m ————————————————————————————————————"
        echo -e "\033[1;32m1、安装小雅媒体库+开心版EMBY\033[0m"
        echo -e "\n"
		echo -e "\033[1;35m2、安装小雅媒体库+官方版EMBY\033[0m"
		echo -e "\n"
		echo -e "\033[1;36m3、仅安装/维护小雅媒体库，不安装EMBY\033[0m"
		echo -e "——————————————————————————————————————————————————————————————————————————————————"
		read -ep "请输入您的选择（1，2或3）；" EMBY_select
        if [[ $EMBY_select == 1 ]]; then
            function4
        elif [[ $EMBY_select == 2 ]]; then
            function5
        elif [[ $EMBY_select == 3 ]]; then
            function6
        else
            echo "输入错误，程序将退出"
            exit 1
        fi
        break
    
    elif [[ $user_select == 3 ]]; then
			read -ep "请输入新建小雅emby的名字（随机生成直接回车）：" e_name
			read -ep "请输入映射到容器6908的宿主机端口：" port_1
	    	read -ep "请输入映射到容器8920的宿主机端口：" port_2
	    	read -ep "请输入映射到容器1900的宿主机端口：" port_3
	    	read -ep "请输入映射到容器7359的宿主机端口：" port_4
	    	read -ep "安装官方版emby直接回车（或输入H回车体验开心版）：" e_happy
	    	localip=$(ip -4 addr show | grep inet | grep -v 127.0.0.1 | grep -v 172. | awk '{print $2}' | cut -d'/' -f1)
	    	if [[ -z "$e_name" ]]; then
	    		containers=$(docker ps -a --format '{{.Names}}' | grep '^emby-lg[0-9]\+$')
				if [[ -z "$containers" ]]; then
				  e_name="emby-lg1"
				else
				  numbers=$(echo "$containers" | grep -o '[0-9]\+' | sort -n)
				  max_number=$(echo "$numbers" | tail -n 1)
				  next_number=$((max_number + 1))
				  e_name="emby-lg$next_number"
				fi
			fi
			
			
			if [[ "$e_happy" == [Hh] ]]; then
				docker run -d --name $e_name --device=/dev/dri --privileged -v /etc/nsswitch.conf:/etc/nsswitch.conf -p $port_1:6908 -p $port_2:8920 -p $port_3:1900/udp -p $port_4:7359/udp --add-host="xiaoya.host:$localip" --user 0:0 --restart always amilys/embyserver:4.8.0.56
			else
				docker run -d --name $e_name --device=/dev/dri --privileged -v /etc/nsswitch.conf:/etc/nsswitch.conf -p $port_1:6908 -p $port_2:8920 -p $port_3:1900/udp -p $port_4:7359/udp --add-host="xiaoya.host:$localip" --user 0:0 --restart always emby/embyserver:4.8.0.56
			fi
			echo -e "\033[1;32m恭喜您！安装已完成！请到群晖docker中添加您需要的config目录和媒体目录开始使用吧！"
			echo -e "\033[1;31m特别提醒：如果您不使用小雅的config作为emby配置目录，请在群晖docker界面中，将容器内的6908端口手动改回8096，否则无法正常使用！\033[0m"
			read -p "按任意键退出程序！"   
    else
        echo -e "输入错误，按任意键重新输入，或按Ctrl+C退出"
    	read -n 1 -s
    fi
done