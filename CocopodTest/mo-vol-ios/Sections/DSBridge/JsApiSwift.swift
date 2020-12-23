//
//  File.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/7/31.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
typealias JSCallback = (String, Bool)->Void

class JsApiSwift: NSObject{
 
 var value = 10
 var feedbankHandler : JSCallback?
 var valueTimer: Timer?
 
 // MARK: - 测试同步方法
 // 必须使用"_"忽略第一个参数名
 @objc func testSyn( _ arg:String) -> String {
     print("js调用了原生的testSyn方法")
     return String(format:"%@[Swift sync call:%@]", arg, "test")
 }
    
 // MARK: - 测试异步有回调
 @objc func testAsyn( _ arg:String, handler: JSCallback) {
     print("js调用了原生的testAsyn方法")
     handler(String(format:"%@[Swift async call:%@]", arg, "test"), true)
 }
 
 // MARK: - 带有dic参数的
 @objc func testNoArgSyn( _ args:Dictionary<String, Any>) -> String{
     print("js调用了原生的testNoArgSyn方法")
     return String("带有dic参数的的方法")
 }
 
 // MARK: - 持续返回进度
 @objc func callProgress( _ args:Dictionary<String, Any> , handler: @escaping JSCallback ){
     print("js调用了原生的callProgress方法")
     feedbankHandler = handler
     valueTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(feedbackValue), userInfo: nil, repeats: true)
 }
    
 //返回进度value
 @objc func feedbackValue() {
     
     if let handler = feedbankHandler {
         if value > 0{
             handler(String(value), false)//上传中
             value -= 1
         }else {
             handler(String(value), true)//上传完成
         }
     }
 }
 
}
