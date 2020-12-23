//
//  HomeRouter.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/4.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit

enum HomeSubmodule: Int {
    
    
    ///原生相机功能的使用
    case photoList
    
    ///DSBridge H5和原生的交互
    case dSBridge
    
    ///原生扫码功测试
    case scanCode
    
    ///字典转模型 反射
    case Model_To_Dictionary
    
    ///反射
    case location
    
    ///WCDB
    case WCDB_VC
    
    //WebRTC_VC
    case WebRTC_VC
    
    ///人脸识别
    case faceRecognition
    
    //["alamofire + moya + HandyJson使用", "DSBridge H5和原生的交互", "反射_基本用法" ,"反射_模型转字典", "WCDB数据库", "WebRTC 音视频直播"]
    var modualDescribtion : String {
        switch self {
            case .photoList:
               return "原生相机功能使用"
                
            case .dSBridge:
               return "DSBridge H5和原生的交互"
            
            case .scanCode:
            return "原生扫码功测试"
            
            case .Model_To_Dictionary:
               return "反射_模型转字典"
            
            case .location:
               return "获取定位信息"
            
            case .WCDB_VC:
               return "WCDB数据库"
            
            case .WebRTC_VC:
               return "WebRTC 音视频直播"
            
            case .faceRecognition:
               return "人脸识别"
        }
    }
    
    static let count = 7
}

class HomeRouter {
    
    weak var contextViewController: HomeViewController?
    
    init(_ contextViewController: HomeViewController) {
        self.contextViewController = contextViewController
    }
}

extension HomeRouter: HomeRouterHandle {
    
    // MARK: - 跳转到相应的模块
    func gotoHomeSubmodule(_ submodule: HomeSubmodule, params: Dictionary<String, Any>?) {
        
        switch submodule {
            
            case .dSBridge:
                let vc = DSbridgeViewController.init()
                self.contextViewController?.navigationController?.pushViewController(vc, animated: true)
        
//            case .Model_To_Dictionary:
//                let vc = Model_To_Dictionary.init()
//                self.contextViewController?.navigationController?.pushViewController(vc, animated: true)
            
//            case .mirrorVC:
//                let vc = Mirror_VC.init()
//                self.contextViewController?.navigationController?.pushViewController(vc, animated: true)

            
//            case .WCDB_VC:
//                let vc = WCDB_VC.init()
//                self.contextViewController?.navigationController?.pushViewController(vc, animated: true)
            
//            case .WebRTC_VC:
//                let vc = WebRTC_VC.init()
//                self.contextViewController?.navigationController?.pushViewController(vc, animated: true)
//
//            case .faceRecognition:
//                let vc = FaceDetectionViewController.init()
//                self.contextViewController?.navigationController?.pushViewController(vc, animated: true)
            
            default :
                break
        }

    }
}
