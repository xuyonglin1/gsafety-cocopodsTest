//
//  DSbridgeViewController.swift
//  mo-vol-ios
//
//  Created by sam   on 2019/8/13.
//  Copyright © 2019 xyl All rights reserved.
//  DSBridge H5和原生的交互

import UIKit
import gsafetyCocopodsTest

class DSbridgeViewController: UIViewController {
    
    static let sharedInstance = DSbridgeViewController()

    public var webview:JMWebView = {
        let webview:JMWebView = JMWebView.init()
        return webview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.title = "DSBridge H5和原生的交互"
        
        //设置webview
        setupWebview()
        //  MARK: - 发布订阅 “registerApns” 事件， 调用js方法
        NotificationCenter.default.addObserver(self, selector: #selector(registerApns), name: Notification.Name(rawValue: "registerApns"), object: nil)
        // 移除观察者
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"shake"), object: nil)
        
        //JS调用原生
        addJsMethod()
        
        //原生调用JS"
//        nativeCallJS()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 隐藏 Webview H5页面 导航栏
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - 设置Webview
    private func setupWebview() {
        webview.frame = self.view.bounds
        // 禁止webview上下拖拉
        webview.scrollView.bounces = false
        self.view.addSubview(webview)
        
        #if DEBUG
        webview.setDebugMode(true)
        #endif
        
        webview.customJavascriptDialogLabelTitles(["alertTitle" : "Notification",  "alertBtn" : "OK"])
        webview.navigationDelegate = self
        //MARK: - 静态页面加载
        let baseUrl = URL.init(fileURLWithPath: Bundle.main.bundlePath)
        let htmlPath = Bundle.main.path(forResource: "test", ofType: "html") ?? ""
        let htmlContent = (try? String.init(contentsOfFile: htmlPath, encoding: String.Encoding.utf8)) ?? ""
        webview.loadHTMLString(htmlContent, baseURL: baseUrl)
        //MARK: -  服务地址加载
//        let request: URLRequest = URLRequest(url: URL(string: "http://172.22.2.42:8080")!)
//        webview.load(request)
    }
    
    // MARK: - 配置命名空间
    private func addJsMethod() {
        //添加原生方法类
        // 文件
        webview.addJavascriptObject(FileApiSwift.init(), namespace: "file")
        webview.addJavascriptObject(FileTransferApi.init(), namespace: "fileTransfer")
        // 相册/录像
//        webview.addJavascriptObject(AlbumApiSwift.init(), namespace: "album")
        webview.addJavascriptObject(MediaApiSwift.init(), namespace: "media")
        // 扫码
//        webview.addJavascriptObject(ScanApiSwift.init(), namespace: "scan")
        webview.addJavascriptObject(ScanApiSwift.init(), namespace: "nfc")
        // 地图
        webview.addJavascriptObject(MapApiSwift.init(), namespace: "map")
        // 定位
        webview.addJavascriptObject(LocationApiSwift.init(), namespace: "location")
        // 通知
        webview.addJavascriptObject(NotificationApiSwift.init(), namespace: "iosPush")
        // 设备电话
        webview.addJavascriptObject(DeviceApiSwift.init(), namespace: "device")
        webview.addJavascriptObject(ConcatsApiSwift.init(), namespace: "concats")

        // 国际化
        webview.addJavascriptObject(InternationalizeApiSwift.init(), namespace: "Internationalize")
        // 录音
        webview.addJavascriptObject(RecordApiSwift.init(), namespace: "record")
        // cocopod插件测试
//        webview.addJavascriptObject(XYLScanApiSwift.init(), namespace: "origionalCore")
    }
    
    //MARK: - APNS消息推送 （IOS调用js方法）
    @objc func registerApns(response: AnyObject) {
        let contents: UNNotificationContent = response.object as! UNNotificationContent
        var msgDict = [String: String]()   // 传输数据
        var extraMap = [String: String]()  // 离线额外数据
        let LocalExtraMap: String?         // 本地额外数据
        // 外层数据
        msgDict["title"] = contents.title as String
        msgDict["content"] = contents.body as String
        if ((contents.userInfo["extraMap"] as? String) != nil) {
            LocalExtraMap = contents.userInfo["extraMap"] as? String
            msgDict["extraMap"] = LocalExtraMap
        } else {
            // 内层数据
            extraMap["id"] = contents.userInfo["id"] as? String
            extraMap["status"] = contents.userInfo["status"] as? String
            extraMap["hub"] = contents.userInfo["hub"] as? String
            extraMap["method"] = contents.userInfo["method"] as? String
            extraMap["publishTime"] = contents.userInfo["publishTime"] as? String
            extraMap["taskTitle"] = contents.userInfo["taskTitle"] as? String
            extraMap["feedContent"] = contents.userInfo["feedContent"] as? String
            
            msgDict["extraMap"] = HandyJsonUtil.dicToJson(extraMap)
        }
        let result: String = HandyJsonUtil.dicToJson(msgDict)!
        // webview 使用原生IOS 调用 前端js语句
        webview.callHandler("APNsPush", arguments: [result]){ (value) in
        }
    }

    
    // MARK: - 原生调用JS
    private func nativeCallJS() {
        print("*************原生调用JS****************")
        
        //原生调用js的addValue方法, 参数是[3, 4], 返回值是value
        webview.callHandler("addValue", arguments: [3, 4]) { (value) in
            print(value ?? "")
        }
        //拼接字符串
        webview.callHandler("append", arguments: ["I", "love", "you"]) { (value) in
            print(value ?? "")
        }
        
        webview.callHandler("startTimer") { (value) in
            print(value ?? "")
        }

        //带有命名空间的方法
        webview.callHandler("syn.addValue", arguments: [5, 6]) { (value) in

            print(value as Any)
        }

        //测试是否js有这个方法
        webview.hasJavascriptMethod("addValue") { (isHas) in
            print(isHas)
        }

        //如果H5调用了window.close方法就会监听到
        webview.setJavascriptCloseWindowListener {
            print("监听到关闭H5页面")
        }
    }
}

extension DSbridgeViewController: WKNavigationDelegate {

}
