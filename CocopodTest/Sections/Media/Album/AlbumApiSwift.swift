//
//  AlbumApiSwift.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/9/23.
//  Copyright © 2020 Gsafety. All rights reserved.
//
//   MARK: -  备注: 本API目前暂时废弃，已经被 MediaApiSwift 取代
//

import Foundation
import UIKit
//import CoreLocation
import Photos

class AlbumApiSwift: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    typealias JSCallback = (Any)->Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // 从相册选择照片
    @objc func selectPicture( _ arg:String, handler: @escaping JSCallback){
        let config = PhotoPickerConfiguration(maxSelection: 10, mediaType: .image) { (resources) in
            // resources为选取的最终资源，图片或者视频的路径
            let optionss = PHContentEditingInputRequestOptions()
            optionss.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData)
                -> Bool in
                return true
            }
            var ImgPaths = [String]()
            for asset in resources{
                let assetemp: PHAsset = asset as! PHAsset
                assetemp.requestContentEditingInput(with: optionss, completionHandler: {(contentEditingInput:PHContentEditingInput?, info: [AnyHashable : Any]) in
                    let myString: String = contentEditingInput!.fullSizeImageURL!.absoluteString
                    ImgPaths.append(myString)
                    // 解决路径返回异步的问题
                    if ImgPaths.count == resources.count {
                        handler(ImgPaths)
                    }
              })
            }
        }
        let picker = PhotoPickerController(config: config)
        let crtvc = ViewControllerHelper.getTopMostViewController()
        crtvc?.present(picker, animated: true, completion: nil)
    }
    // 从相册选择视频
    @objc func selectVideo( _ arg:String, handler: @escaping JSCallback){
        let config = PhotoPickerConfiguration(maxSelection: 10, mediaType: .video) { (resources) in
            // resources为选取的最终资源，图片或者视频的路径
            var filePaths = [String]()
            for asset in resources{
                let options = PHVideoRequestOptions()
                options.version = PHVideoRequestOptionsVersion.current
                options.deliveryMode = PHVideoRequestOptionsDeliveryMode.automatic
                let manager = PHImageManager.default()
                let assetemp: PHAsset = asset as! PHAsset
                manager.requestAVAsset(forVideo: assetemp, options: options, resultHandler: { (asset, audioMix, info) in
                    let avAsset = asset as? AVURLAsset
                    let myString: String = (avAsset?.url.absoluteString)!
//                    filePath = myString
                    filePaths.append(myString)
                    // 解决路径返回异步的问题
                    if filePaths.count == resources.count {
                        handler(filePaths)
                    }
                })

            }
        }
        let picker = PhotoPickerController(config: config)
        let crtvc = ViewControllerHelper.getTopMostViewController()
        crtvc?.present(picker, animated: true, completion: nil)
    }
}
