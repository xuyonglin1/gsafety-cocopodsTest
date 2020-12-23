//
//  NetworkController.swift
//  mo-vol-ios
//
//  Created by Gsafety on 2020/12/10.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import Alamofire

class NetworkController: NSObject {
    
    typealias Callback = (String)->Void

    func AlamofiremonitorNet(reachabilityStatus:  @escaping Callback) {
        let manager = NetworkReachabilityManager.init()
        manager?.startListening { (status) in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.ethernetOrWiFi){
                reachabilityStatus("ethernetOrWiFi")          // wifi
            }
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                reachabilityStatus("notReachable")  // 不可用
            }
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown{
                reachabilityStatus("unknown")       // 未知
            }
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.cellular){
                reachabilityStatus("wwan")          // 蜂窝
            }
        }
    }
    
}
