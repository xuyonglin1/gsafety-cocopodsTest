//
//  DeviceApiSwift.swift
//  mo-vol-ios
//
//  Created by guo on 2020/10/20.
//  Copyright © 2020 Gsafety. All rights reserved.
//
//  进程通讯 参考：https://www.cnblogs.com/-ios/p/8385458.html
//  网络监听 参考：https://blog.csdn.net/qq_22955427/article/details/107670691
import Foundation
import UIKit
import CoreLocation

class DeviceApiSwift: UIViewController {
    
    typealias JSCallback = (Any)->Void
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   // MARK: - 打电话
   @objc func makePhoneCall( _ arg: String, handler: @escaping JSCallback){
    print(arg)
    let phoneNumber = arg
    if phoneNumber.isEmpty {
            print("电话号码异常")
        } else {
        var tel = "tel://" + phoneNumber
            //去掉空格-不然有些电话号码会使 URL 报 nil
            tel = tel.replacingOccurrences(of: " ", with: "", options: .literal, range: nil);
            print(tel)
            if let urls = URL(string: tel){
                //ios 10.0以上和一下调用不同的方法拨打电话-默认都会弹框询问
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(urls, options: [:], completionHandler: {
                       (success) in
                        print("Open success")
                    })
                } else {
                    UIApplication.shared.openURL(urls)
                }
            }else{
                print("url 为空!")
            }
        }
    }
    // MARK: - 发短信
    @objc func sendMessage( _ arg: Any, handler: @escaping JSCallback){
        let messageController = MessageController()
        messageController.sendMessage(arg)
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: 1)
        print(jsresult!)
        handler(jsresult!)
    }
    // MARK: - 获取设备系统信息
    @objc func getSystemInfo( _ arg: Any, handler: @escaping JSCallback){
        let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
//        let deviceName = UIDevice.current.name  //获取设备名称 例如：辰安的ipnone11
        let sysName = UIDevice.current.systemName //获取系统名称 例如：iPhone OS
        let sysVersion = UIDevice.current.systemVersion //获取系统版本 例如：9.2
        // uuid为app标识，会变， 设备标识UDID被屏蔽了获取不到。 例如：FBF2306E-A0D8-4F4B-BDED-9333B627D3E6
        let deviceUUID = UIDevice.current.identifierForVendor?.uuidString
        let deviceModel = UIDevice.current.modelName //获取设备的型号 例如：iPhone
        let deviceInfo:[String : Any] = ["deviceID": deviceUUID as Any, "model": deviceModel, "ststem": sysName + " " + sysVersion, "course":deviceModel, "versionName":appVersion]
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: deviceInfo)
        handler(jsresult!)
    }
    
    // MARK: - 获取设备定位信息方法
    @objc func getLocation( _ arg:Any, handler: @escaping JSCallback){
        if localPermissionCheck() {
//            print("有权限")
        }
        LocationController.sharedInstance.getUserCCLocation { (location) in
            let latitude = location?.coordinate.latitude
            let longitude = location?.coordinate.longitude
            let speed = location?.speed
            let course = location?.course
            let locations:[String : Any] = ["latitude":latitude as Any, "longitude":longitude as Any, "speed":speed as Any, "course":course as Any]
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: locations)
            handler(jsresult!)
        }
    }
    // 判断定位权限
    func localPermissionCheck() -> Bool{
        let mgr = LocationController.sharedInstance
        let success = mgr.isLocationServiceSuccess { (alertControllers) in
            for ctrs in alertControllers {
                self.present(ctrs, animated: true, completion: nil)
            }
        }
        return success
    }
    
    // MARK: - 获取网络类型
    @objc func getNetworkType( _ arg: Any, handler: @escaping JSCallback){
        let networkController = NetworkController()
        networkController.AlamofiremonitorNet(reachabilityStatus: { (status) in
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: status)
            print(jsresult!)
            handler(jsresult!)
        })
    }
    // MARK: - 企业IPA包更新
    @objc func updateIPA( _ arg: Any, handler: @escaping JSCallback){
        print("点到了")
        let url = NSURL(string: "itms-services://?action=download-manifest&url=https://cisp-project.com:10017/examples/manifest.plist")
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
    
    // MARK: - 进程通信
    @objc func processCommunication( _ arg: Any, handler: @escaping JSCallback){
        print("。。。。。。。")
        let urlString = "weixin://"
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
