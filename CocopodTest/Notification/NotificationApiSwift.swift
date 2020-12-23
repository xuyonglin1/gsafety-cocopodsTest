//
//  NotificationAp.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/10/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//  参考 https://www.jianshu.com/p/0f0dd782fdd5

import UIKit
import AVFoundation



class NotificationApiSwift: UIViewController {

    typealias JSCallback = (Any)->Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
   // MARK: - 显示本地消息方法方法
   // 必须使用"_"忽略第一个参数名
   @objc func showNotification( _ arg:Any, handler: @escaping JSCallback){
        print("这是本地消息")
        let msg : NSDictionary = arg as! NSDictionary
        print(msg)
//        print(HandyJsonUtil.modelToDictionary(arg as! NotifiDateModel))
        let content = UNMutableNotificationContent()
        content.title = msg["title"] as! String
//        content.title =  "消息标题"
        //content.subtitle = "This is subtitle"
        content.body = msg["content"] as! String
//        content.body = "消息内容"
        if ((msg["extraMap"] as? String) != nil) {
            let extraMap:[String: String] = ["extraMap": msg["extraMap"] as! String]
            content.userInfo = extraMap
        }
        content.sound = UNNotificationSound.default
        content.badge = 0
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "calendar", content: content, trigger: trigger)
           
        // Schedule the request with the system.
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
               print("Failed to add request to notification center. error:\(error)")
            }
        }
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: "resUrl")
        handler(jsresult!)
   }
    
    // MARK: - 获取APNs token 方法
    // 必须使用"_"忽略第一个参数名
    @objc func getAPNsToken( _ arg:Any, handler: @escaping JSCallback){
        let userDefault = UserDefaults.standard
        let stringValue: String = userDefault.string(forKey: "NotificationToken") ?? ""
        print(stringValue)
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: stringValue)
        handler(jsresult!)
    }
    
}
