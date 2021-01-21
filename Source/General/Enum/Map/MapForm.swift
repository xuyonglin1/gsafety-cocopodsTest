//
//  File.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/27.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation

//地图类型
enum MapForm {
    enum MapURI:String {
        //百度
        case baiduMap = "baidumap://"
        //高德
        case gaodeMap = "iosamap://"
        //苹果
        case appleMap = "http://maps.apple.com/"
        //谷歌
        case googleMap = "comgooglemaps://"
        //腾讯
        case qqMap = "qqmap://"
    }
    enum MapName:String {
        //百度
        case baiduMap = "百度地图"
        //高德
        case gaodeMap = "高德地图"
        //苹果
        case appleMap = "系统地图"
        //谷歌
        case googleMap = "谷歌地图"
        //腾讯
        case qqMap = "腾讯地图"
    }
}
