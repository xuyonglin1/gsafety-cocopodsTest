# IOS打包IPA
基于IOS壳工程打企业账号的ios下载包

## 创建新的app ID
(1) 进入苹果开发者官网：https://developer.apple.com/
(2) 选择 Account - Certificates, Identifiers & Profiles - Identifiers 点 “+” 号
(3) 输入项目Description和Bundle ID 点击下一步即可完成；Capabilities可根据项目需要进行选择，后面可以修改。

## 创建证书

创建请求证书文件：
(1) 首先打开应用程序-实用工具-钥匙串访问,在证书助理中,选择"从证书颁发机构求证书"
(2) 填你申请idp的电子邮件地址，常用名称，CA电子邮件地址空，请求是:存储到磁盘，点击右下角"继续"：

制作Provisioning Profile证书文件：
(1) 登录到开发者中心，找到证书配置的版块"Certificates, Identifiers & Profiles"
(2) 选择Certificates ，选择All Types，点击“+”号
(3) Software 下勾选 “Apple Development” 点击下一步
(4) 在Choose File 中选择刚生成在桌面的 CertificateSigningRequest.certSigningRequest 证书
(5) 点击 Dowmload 下载 development.cer / distribution.cer (生产环境和开发环境)

制作Provisioning Profile证书

(1) 选择 Profiles，选择All Types，点击“+”号
(2) Distribution 下勾选 “Ad Hoc” 点击下一步 ， 选择 App ID，选择对应的证书（注意开发环境和生产环境的要对应）
(3) 完成后点击 Dowmload 下载 Macao_volunteer.mobileprovision(生产环境和开发环境)


编译生成IPA包

(1) 打开Xcode ，选择 Product - Archive；
(2) 点击distribute app ，选择 AD hc点击下一步，只勾选第二项 下一步；
(3) 网站随意输入下一步，勾选第二项 Manually，选择上面对应的Provisioning Profile证书下一步；
(4) 即可完成导出文件到本地，
(5) 利用蒲公英网站发布IOS包供手机下载。
