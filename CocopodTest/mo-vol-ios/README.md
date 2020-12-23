# MO-VOL-IOS  
基于IOS壳工程开发的澳门民防志愿者项目

## 工程简介

### 核心工程目录
```
MO-VOL-IOS
├── mo-vol-ios
│   ├── doc                               开发相关文档
│   ├── mo-vol-ios                        工程开发主目录
│   │   ├── AppDelegate.swift             应用的入口文件
│   │   ├── mo-vol-ios-Bridging-header.h   swift与Object-C桥接头文件
│   │   ├── Assets.xcassets               app图标配置文件
│   │   ├── Application                   启动类相关目录
│   │   │   ├── ThirdLibsManager          管理第三方库启动项
│   │   │   └── OnBoarding                启动App所需要的基础服务
│   │   ├── Models                        放一些与数据相关的Model文件
│   │   │   └── xxx
│   │   ├── Enum                          放枚举类型文件
│   │   │   └── xxx
│   │   ├── Macro                         宏定义：第三方常量
│   │   │   └── xxx
│   │   ├── General                       放会被重用的Views/Classes和Categories
│   │   │   └── xxx
│   │   ├── Helpers                       放一些助手类，文件名与功能挂钩
│   │   │   └── xxx
│   │   ├── Vendors                       放第三方的类库/SDK，如UMeng、WeiboSDK、WeixinSDK
│   │   │   └── xxx
│   │   ├── Resources                     静态资源目录
│   │   │   └── xxx
│   │   ├── Sections                      app主要业务模块
│   │   │   └── xxx
│   ├── mo-vol-iosTests                   工程测试主目录
│   ├── mo-vol-iosUITests                 工程UI测试主目录
│   ├── Pods                              pod插件配置目录(自动更新)
│   └── Frameworks                        框架存放目录
Pods
└── Podfile                               第三方插件配置文件
```  

## 快速启动项目

1. 使用smartgit工具，将代码clone到本地
2. 在访达中选择mo-vol-ios.xcworkspace(白色)文件启动项目
3. 在命令工具中cd到项目路径下，执行`pod install`安装依赖
4. 点击右三角启动按钮，运行项目。





### Appdelegate优化启动配置： 服务化思想

