#!/bin/bash
#https://github.com/starFalll/Ubuntu_Init/
#
#Program:
#	linux environment configuration initialization
#	1.change sources.list,from official sources to USTC sources(16.04)/163 sources(14.04).
#	2.update and upgrade softwares.
#	3.install vim.
#	4.install sougoupinyin.
#	5.change directory to english.
#	6.delete some useless softwares.
#	7.System landscaping.
#	8.install vs code/sublime
#	9.install uget
#	10.install typora
#	11.install chrome
#	12.install netease-cloud-music
#	13.install docky
#History:
#2018/01/27	ACool	42th  release

Sources=$(cat /etc/issue |sed -n "1,1p"| awk '{print $2}'|cut -d '.' -f 1,2)
mkdir Backup

sudo rm /var/lib/apt/lists/lock
sudo rm /var/lib/dpkg/lock
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove


echo -e "Is your computer dual boot?(您的电脑是双系统吗)(Y/n) :\c"
read  result_2
if [ "${result_2}" == "Y" ] || [ "${result_2}" == "y" ]; then
	sudo apt-get install -y ntpdate
	sudo ntpdate time.windows.com
	sudo hwclock --localtime --systohc
fi

echo -e "***************************************************************************************"
echo -e "*Please select the following softwares to install:                                    *"
echo -e "*(请选择以下软件安装)                                                                 *"
echo -e "*1.sougoupinyin(搜狗拼音输入法)                                                       *"
echo -e "*2.chrome(会卸载自带的firefox)                                                        *"
echo -e "*3.netease-cloud-music(网易云音乐)                                                    *"
echo -e "*4.docky(https://github.com/starFalll/Ubuntu_Init/blob/master/README.md#what-is-docky)*"
echo -e "***************************************************************************************"
echo -e "Please input your chooses (1/2/3/4) (请输入选择序号,一共四个参数,未选择的请输0,例:1 0 1 0):\c"
read YN browser Music Docky
echo -e "****************************************************"
echo -e "*Please select the following editor to install:    *"
echo -e "*(请选择以下编辑器安装)                            *"
echo -e "*1.Visual Studio Code                              *"
echo -e "*2.sublime text3                                   *"
echo -e "*3.no editor                                       *"
echo -e "****************************************************"
echo -e "Please input your choose (1/2/3) (请输入选择序号):\c"
read editer

##Download softwares
sudo apt-get install -y vim
sudo add-apt-repository -y ppa:plushuang-tw/uget-stable
sudo apt-get update
sudo apt-get -y install uget
sudo apt-get install -y aria2i


if [ "${YN}" == "1" ] ; then
	sudo apt-get remove -y fcitx*
	sudo apt-get autoremove
	rm sogoupinyin_2.1.0.0086_amd64.deb*
	wget -q http://cdn2.ime.sogou.com/dl/index/1491565850/sogoupinyin_2.1.0.0086_amd64.deb?st=H6Fv3RXvgGFlgWBT3xkMZw&e=1507788214&fn=sogoupinyin_2.1.0.0086_amd64.deb
	echo -e "Install sougoupinyin,Please wait...\c"
	sleep 300
	sudo dpkg -i sogoupinyin*
	sudo apt-get -yf install 
	sudo dpkg -i sogoupinyin*

#	echo -e "\033[46;37m Please read the page: https://github.com/starFalll/Ubuntu_Init/blob/master/README.md#sogou-pinyin-input-method-configuration \033[0m"
#	read -p "Have you followed the instructions?(您已经按照说明更改配置了吗?)(Y/n)" result_3
#	if [ "${result_3}" == "n" ] || [ "${result_3}" == "N" ]; then
#        	echo -e "\033[46;37m Please follow the instructions. \033[0m"
#        	read -p "Continue?(Y/n)" result_4
#        	if [ "${result_4}" == "n" ] || ["${result_4}" == "N" ]; then
#                	exit 0
#        	fi
#	fi
fi

if [ "${Docky}" == "1" ];then
	sudo apt-get -y install docky
fi


if [ "${editer}" == "1" ]; then
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sleep 4
	sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt-get update
	sudo apt-get -y install code
	echo -e "\033[46;37m VS code was installed successfully! \033[0m"
	echo -e "\033[46;37m (vscode安装成功!) \033[0m"
	sleep 3

elif [ "${editer}" == "2" ]; then
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sleep 2
	sudo apt-get install -y  apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get -y install sublime-text
	echo -e "\033[46;37m The sublime text3 was installed successfully! \033[0m"
	echo -e "\033[46;37m (sublime安装成功!) \033[0m"
	sleep 3
else 
	echo -e"\033[41;37m No editor was installed! \033[0m"	
	echo -e"\033[41;37m (没有安装编辑器!) \033[0m"
	sleep 3
fi


if [ "${browser}" = "1" ]; then
	wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	sudo apt-get update
	sudo apt-get -y install google-chrome-stable

fi

if [ "${Music}" == "1" ]; then
        wget -q http://d1.music.126.net/dmusic/netease-cloud-music_1.1.0_amd64_ubuntu.deb 
	echo -e "Install netease-cloud-music,Please wait...\c"
        sleep 150
	sudo dpkg -i netease-cloud-music*
        sudo apt-get -yf install
        sudo dpkg -i netease-cloud-music*

fi

if [ $LANG == "zh_CN.UTF-8" ]; then
	echo -e "\033[44;37m change directory to english,convenienting command line opration. \033[0m"
	echo -e "\033[44;37m (改变中文目录为英文，方便命令行操作.) \033[0m"
sleep 4

export LANG=en_US
xdg-user-dirs-gtk-update
export LANG=zh-CN

fi

clear

echo -e "成功执行以下操作：***************************" | tee install.log
echo -e "- 更换USTC源                                *" | tee -a install.log
echo -e "- 更新系统软件到最新版本                    *" | tee -a install.log
echo -e "- 更换目录为英文(若是中文目录的话)          *" | tee -a install.log
echo -e "- 同步windows/Ubuntu双系统时间(若是双系统)  *" | tee -a install.log
echo -e "- 安装vim                                   *" | tee -a install.log
echo -e "- 安装openjdk8                              *" | tee -a install.log
echo -e "- 删除Amazon的链接                          *" | tee -a install.log
echo -e "- 安装标题栏网速监控软件                    *" | tee -a install.log
echo -e "- 系统美化                                  *" | tee -a install.log
echo -e "- 安装uGet下载管理器                        *" | tee -a install.log
echo -e "- 安装Typora优雅的markdown编辑器            *" | tee -a install.log
if [ "${editer}" == "1" ]; then
echo -e "- 安装VS code编辑器                         *" | tee -a install.log
elif [ "${editer}" == "2" ]; then
echo -e "- 安装sublime text3编辑器                   *" | tee -a install.log
fi
if  [ "${YN}" == "1" ] ; then
echo -e "- 安装搜狗中文输入法                        *" | tee -a install.log
fi
if [ "${browser}" = "1" ]; then
echo -e "- 安装Chrome                                *" | tee -a install.log
fi
if [ "${Music}" == "1" ]; then
echo -e "- 安装网易云音乐                            *" | tee -a install.log
fi
echo -e "*********************************************" | tee -a install.log
echo -e "(配置信息保存在install.log文件中.)"
echo -e "\033[46;37m The configuration is complete.(配置完成!) \033[0m"
if  [ "${YN}" == "1" ] ; then
echo -e "请重启后按照以下页面配置:https://github.com/starFalll/Ubuntu_Init/blob/master/README.md#sogou-pinyin-input-method-configuration"
fi

echo -e "Reboot now?(是否立即重启？)(Y/n) :\c"
read result_7



if [ "${result_7}" == "Y" ] || [ "${result_7}" == "y" ];then
	sudo reboot
elif [ "${result_7}" == "N" ] || [ "${result_7}" == "n" ];then
	echo -e "\033[41;37m Please reboot later.(请稍后重启) \033[0m"
fi





