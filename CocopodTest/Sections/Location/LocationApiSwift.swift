//
//  location.swift
//  mo-vol-ios
//
//  Created by XYL on 2020/9/1.
//  Copyright © 2020 Gsafety. All rights reserved.
//
//  备注：安卓命名空间为device 这里和安卓保持一致

import UIKit
import CoreLocation

class LocationApiSwift: UIViewController {

    typealias JSCallback = (Any)->Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - 获取定位信息（此方法在device文件中）
    @objc func getLocation( _ arg:Any, handler: @escaping JSCallback){
        print(arg)
        if check() {
            print("有权限")
        }
        print("获取地理信息！！！")
        LocationController.sharedInstance.getUserCCLocation { (location) in
            let latitude = location?.coordinate.latitude
            let longitude = location?.coordinate.longitude
            let speed = location?.speed
            let course = location?.course
            let locations:[String : Any] = ["latitude":latitude as Any, "longitude":longitude as Any, "speed":speed as Any, "course":course as Any]
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: locations)
            print(jsresult!)
            handler(jsresult!)
        }
    }
    
    func check() -> Bool{
        let mgr = LocationController.sharedInstance
        let success = mgr.isLocationServiceSuccess { (alertControllers) in
            for ctrs in alertControllers {
                self.present(ctrs, animated: true, completion: nil)
            }
        }
        print(success)
        return success
    }
    
}
