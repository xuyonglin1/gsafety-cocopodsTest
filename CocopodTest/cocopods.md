配置cocopods环境：
打开命令下载cocopods ；sudo gem install cocoapods

打开项目地址 pod init  生产podFile文件，用于配置pod依赖

cd ~/.cocoapods/repos 进入coco的目录

git clone https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git master

配置清华大学镜像代理；注意同时修改 项目podFile镜像 
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
