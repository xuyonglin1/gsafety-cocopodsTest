//
//  AppDelegate.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/7/29.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit
import UserNotifications
import AudioToolbox


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    private let onBoarding = OnBoarding()
    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    // MARK: 程序启动的时候第一次运行方法
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NSLog("项目启动！")
        // MARK: 统一管理第三方库
        // hirdLibsManager.shared.setup()
        
        // 注册册通知
        UIApplication.shared.registerForRemoteNotifications()
        UNUserNotificationCenter.current().delegate = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        onBoarding.start(with: AppRouter(window: window!))
        window?.makeKeyAndVisible()
        
        // 判断是否有通知权限
        let result = UIApplication.shared.isRegisteredForRemoteNotifications
        if !result {
            registerForPushNotifications()
        }
        // 国际化配置
        object_setClass(Foundation.Bundle.main, Bundles.self)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        let userDefault = UserDefaults.standard
        // 缓存APNs token
        userDefault.set(token, forKey: "NotificationToken")
    }
    // 失败回调
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
       // Try again later.
        print(error)
    }
    /** 接收本地通知 */
    
    //    请求权限推送通知
    func registerForPushNotifications() {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) {
          [weak self] granted, error in
          print("Permission granted: \(granted)")
          guard granted else { return }
          self?.getNotificationSettings()
      }
    }
    
    func getNotificationSettings() {
//        参考：https://www.raywenderlich.com/8164-push-notifications-tutorial-getting-started
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        guard settings.authorizationStatus == .authorized  else {
            return
        }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
    // app打开时 收到通知回调事件
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 建立的SystemSoundID对象,标准长震动
        let soundID = SystemSoundID(kSystemSoundID_Vibrate)
        // 执行震动
        AudioServicesPlaySystemSound(soundID)
        
        print(notification.request.content.title)
        print(notification.request.content.body)
        // 获取通知附加数据
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        //        NotificationCenter.default.post(name: Notification.Name(rawValue: "registerApns"), object: "nil")
    }
    // app在background或杀死进程后，点击消息的回调事件
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("语文界")
        let contents = response.notification.request.content
//        //获取通知附加数据
        NotificationCenter.default.post(name: Notification.Name(rawValue: "registerApns"), object: contents)
    }
}

