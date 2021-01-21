//
//  LocationUtils.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import MapKit

class LocationUtils {
    
    class func isCoordinateOutOfChina(coordinate:CLLocationCoordinate2D) -> Bool{
        return coordinate.longitude < 72.004 || coordinate.longitude > 137.8347 || coordinate.latitude < 0.8293 || coordinate.latitude > 55.8271
    }
    
    class func transformToGCJ(fromWGS wgsLoc:CLLocationCoordinate2D) ->CLLocationCoordinate2D{
        let a = 6378245.0;
        let ee = 0.00669342162296594323;
        let pi = 3.14159265358979324;
        
        func transformLat(x:CLLocationDegrees,y:CLLocationDegrees) -> CLLocationDegrees {
            var lat:CLLocationDegrees = -100.0 + 2.0 * x + 3.0 * y
            lat += 0.2 * y * y
            lat += 0.1 * x * y + 0.2 * sqrt(abs(x))
            lat += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
            lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0
            lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0
            return lat;
        }
        
        func transformLog(x:CLLocationDegrees,y:CLLocationDegrees) -> CLLocationDegrees {
            var lon:CLLocationDegrees = 300.0 + x + 2.0 * y + 0.1 * x * x
            lon += 0.1 * x * y + 0.1 * sqrt(abs(x))
            lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
            lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0
            lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0
            return lon;
        }


        var adjustLat = transformLat(x: wgsLoc.longitude - 105.0, y: wgsLoc.latitude - 35.0);
        var adjustLon = transformLog(x: wgsLoc.longitude - 105.0 ,y: wgsLoc.latitude - 35.0);
        let radLat = wgsLoc.latitude / 180.0 * pi;
        var magic = sin(radLat);
        magic = 1 - ee * magic * magic;
        let sqrtMagic = sqrt(magic);
        adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
        adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
        
        return CLLocationCoordinate2D(latitude: wgsLoc.latitude + adjustLat, longitude: wgsLoc.longitude + adjustLon);
    }
}
