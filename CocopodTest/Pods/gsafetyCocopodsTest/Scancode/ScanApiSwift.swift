//
//  ScanViewController.swift
//  mo-vol-ios
//  MARK: 扫码功能 JS API
//  Created by XYL on 2020/8/20.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit
import AVFoundation



public class ScanApiSwift: NSObject{

    typealias JSCallback = (Any)->Void
    
   // MARK: - 扫码方法
   // 必须使用"_"忽略第一个参数名
   @objc func scanCode( _ arg:Any, handler: @escaping JSCallback){
        let vc = ScanViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.completeBlock = { url in
            NSLog("扫码成功： " + url)
            let resUrl: String = url
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: resUrl)
            handler(jsresult!)
        }
        let crtvc = topViewController()
        crtvc?.navigationController?.pushViewController(vc, animated: true)
   }
    
   @objc func scanCodeByAlbum( _ arg:Any, handler: @escaping JSCallback){
    let config = PhotoPickerConfiguration(maxSelection: 1, mediaType: .image) { (resources) in
       // 调整传递到js的数据格式
        for asset in resources{
            let qrcodeImg = UIImage(contentsOfFile: asset as! String)
            let ciImage:CIImage=CIImage(image:qrcodeImg!)!
            
            let context = CIContext(options: nil)
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context,options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
            
            let features = detector?.features(in: ciImage)
            
            var resUrl: String?
            print("扫描到二维码个数：\(features?.count ?? 0)")
            // 遍历所有的二维码，并框出
            for feature in features as! [CIQRCodeFeature] {
                print(feature.messageString ?? "")
                resUrl = feature.messageString ?? ""
            }
            
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: resUrl as Any)
            handler(jsresult!)
        }
    }
    let picker = PhotoPickerController(config: config)
    let crtvc = ViewControllerHelper.getTopMostViewController()
    crtvc?.present(picker, animated: true, completion: nil)
   }
}

extension UIColor {
    public func image() -> UIImage {
         let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
         UIGraphicsBeginImageContext(rect.size)
         let context = UIGraphicsGetCurrentContext()
         context!.setFillColor(self.cgColor)
         context!.fill(rect)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return image!
     }
}
