//
//  TestMap.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/10/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import AVFoundation


public class MapApiSwift: NSObject {

    typealias JSCallback = (Any)->Void
    
   // MARK: - 测试同步扫码方法
   // 必须使用"_"忽略第一个参数名
    @objc func getMaps( _ arg:Any, handler: @escaping JSCallback){
        //盛放地图元素的数组
        var maps = [String]()
        //自带地图
        if UIApplication.shared.canOpenURL(URL(string: MapForm.MapURI.appleMap.rawValue)!) {
            let iosMap = "appleMap"
            maps.append(iosMap)
        }
        //百度地图
        if UIApplication.shared.canOpenURL(URL(string: MapForm.MapURI.baiduMap.rawValue)!) {
            let baiduDic = "baiduMap"
            maps.append(baiduDic)
        }
        //高德地图
        if UIApplication.shared.canOpenURL(URL(string: MapForm.MapURI.gaodeMap.rawValue)!) {
            let gaodeDic = "gaodeMap"
            maps.append(gaodeDic)
        }
        //谷歌地图
        if UIApplication.shared.canOpenURL(URL(string: MapForm.MapURI.googleMap.rawValue)!) {
            let googleDic = "googleMap"
            maps.append(googleDic)
        }
        //腾讯地图
        if UIApplication.shared.canOpenURL(URL(string: MapForm.MapURI.qqMap.rawValue)!) {
            let qqDic = "qqMap"
            maps.append(qqDic)
        }
        if maps.count == 0 {
            handler("null")
            return
        }
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: maps)
        print(jsresult!)
        handler(jsresult!)
    }
    @objc func openMap(  _ args:Dictionary<String, Any>, handler: @escaping JSCallback){
        let mapModel:MapDateModel = HandyJsonUtil.dictionaryToModel(args,MapDateModel.self) as! MapDateModel
        let latitute = mapModel.lat
        let longitute = mapModel.lon
        let endAddress = mapModel.address
        switch mapModel.mapType! {
            case "appleMap"  :
                print( "苹果地图")
                self.appleMap(lat: latitute!, lng: longitute!, destination: endAddress!)
                handler("success")
            case "baiduMap"  :
                print( "百度地图")
                self.baidumap(endAddress: endAddress!, lat: latitute!,lng: longitute!)
                handler("success")
            case "gaodeMap"  :
                print( "高德地图")
                self.iosamap(endAddress: endAddress!,dlat: latitute!, dlon: longitute!, dname: endAddress!, way: 0)
                handler("success")
            case "qqMap"  :
                print( "腾讯地图")
                self.qqMap(endAddress: endAddress!,lat: latitute!, lng: longitute!)
                handler("success")
            case "googleMap"  :
                print( "谷歌地图")
                self.googleMap(endAddress: endAddress!,lat: latitute!, lng: longitute!)
                handler("success")
            default :
                print( "默认 case")
                let aa = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: "success")
//                print(aa!)
                handler(aa!)
        }
    }
    
    
    //  MARK: - 打开苹果地图
    func appleMap(lat:Double,lng:Double,destination:String){
        let loc = CLLocationCoordinate2DMake(lat, lng)
        let currentLocation = MKMapItem.forCurrentLocation()
        let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
        toLocation.name = destination
        MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: "true"])
    }
    
    //  MARK: - 打开高德地图
    func iosamap(endAddress:String,dlat:Double,dlon:Double,dname:String,way:Int) {
        let appName = "app的名字"
        let urlString = "iosamap://path?sourceApplication=导航功能&backScheme=\(appName)&poiname=\(endAddress)&poiid=BGVIS&lat=\(dlat)&lon=\(dlon)&dname=\(endAddress)&dev=0&m=0" as NSString
        print(urlString)
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
//        UIApplication.shared.openURL(url! as URL)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
    
    //  MARK: - 打开百度地图
    func baidumap(endAddress:String,lat:Double,lng:Double) {
        let urlString = "baidumap://map/direction?origin={{我的位置}}&destination=name:\(endAddress)|latlng:\(lat),\(lng)&mode=driving&src=\(endAddress)&coord_type=gcj02"
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
    //  MARK: - 打开腾讯地图
    func qqMap(endAddress:String,lat:Double,lng:Double) {
        let urlString = "qqmap://map/routeplan?type=drive&from=我的位置&to=\(endAddress)&tocoord=\(lat),\(lng)&referer=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77"
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
    //  MARK: - 打开Google地图
    func googleMap(endAddress:String,lat:Double,lng:Double) {
        let urlString = "comgooglemapsurl://maps.google.com/maps?f=d&daddr=\(endAddress)&sll=\(lat),\(lng)&sspn=0.2,0.1&nav=1"
        let url = NSURL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
}
