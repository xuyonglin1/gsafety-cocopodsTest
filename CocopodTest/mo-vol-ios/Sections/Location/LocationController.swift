//
//  LocationController.swift
//  mo-vol-ios
//
//  Created by XYL on 2020/9/4.
//  Copyright © 2020 Gsafety. All rights reserved.
//
//  参考资料：https://github.com/lengqingfeng/SwiftLocationManager
//          https://www.jianshu.com/p/d31063c5ff83
//

import UIKit
import CoreLocation
import MapKit
public enum LocationServiceStatus :Int {
    case Available
    case Undetermined
    case Denied
    case Restricted
    case Disabled
}

public typealias userCLLocation = ((_ location: CLLocation?) -> Void)
public typealias cityString = ((_ city: String? ) -> Void)

private let DistanceAndSpeedCalculationInterval = 5.0;

public class LocationController: NSObject,CLLocationManagerDelegate{

//    public let SwiftLocationManagerSharedInstance = SwiftLocationManager()
    static let sharedInstance1 = LocationController()
    //创建一个单例
    public class var sharedInstance:LocationController {
       return sharedInstance1
    }
    public var userLocation: CLLocation?
    
    //定义闭包变量
    private var onUserCLLocation: userCLLocation?
    private var onCityString:cityString?
    //上一次定位时间
    public var LastDistanceAndSpeedCalculation:Double = 0
    
    
    //创建一个 CLLocationManager 对象
    private var locationManager:CLLocationManager!
    
    private override init() {}
    
    //MARK:- 初始化 CLLocationManager
    func config() {
        
        guard isLocationServiceEnabled() else {
            return
        }
        
        locationManager = CLLocationManager()
        
        let status  = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        //精度最高
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //距离改变1000 米后再次定位
        locationManager.distanceFilter = 1000
        locationManager.delegate = self
        //开始定位
        locationManager.startUpdatingLocation()
    }
    
    // 检查整个手机定位系统是否可用
    private func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            return true
        }else {
            return false
        }
    }
    private func isLocationServiceOpen() -> Bool {
        // denied 被用户禁止
        // restricted 活动受限
        if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
            return false
        } else {
            return true
        }
    }
    
    func combineAlertController(title: String, message: String, open: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("local_cancel", comment: "取消") , style: .default, handler: nil)
        let okAction = UIAlertAction(title: NSLocalizedString("local_confirm", comment: "确定"), style: .default, handler: { (_) in
            self.openAppSetting(str: open)
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
    }
    // UIApplication.openSettingsURLString --- app 定位
    func openAppSetting(str: String) {
        guard let url = URL(string: str) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    //MARK:- 检查权限是否可用
    func isLocationServiceSuccess(handler: (_ actions: [UIAlertController])->()) -> Bool {
       var arts = [UIAlertController]()
       if !isLocationServiceEnabled() { // 手机定位没开
           // 添加一个alertContrller 跳转手机定位设置
       }
       if !isLocationServiceOpen() { // app定位没开
           let alert = combineAlertController(title: NSLocalizedString("scan_noLocationPermission", comment: "无位置权限"), message: NSLocalizedString("scan_noLocationPermissionMessage", comment: "请在iphone的“设置-隐私-定位”选项中，允许应用访问你的位置"), open: UIApplication.openSettingsURLString)
           arts.append(alert)
       }
       if arts.count > 0 {
           handler(arts)
           return false
       }
       return true
   }
    
   //MARK:- locationManager
   public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //停止定位
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil;
        print("Error \(error.localizedDescription)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let location = CLLocation(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
        let currentLocation = LocationUtils.transformToGCJ(fromWGS: location.coordinate)
        let userLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        onUserCLLocation!(userLocation)
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil;
    }

    
    //MARK:- 获取经纬度
    func getUserCCLocation(cllocation:@escaping userCLLocation) -> Void {
        config()
        onUserCLLocation = cllocation;
    }
}
