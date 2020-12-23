//
//  MediaApiSwift.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation
import Photos
class MediaApiSwift: NSObject, UINavigationControllerDelegate{
    
    typealias JSCallback = (Any)->Void
    
     var feedbankHandler : JSCallback?
     var localId:String!
    
    /*
     *  MARK: - 从相册选择 照片
    */
    @objc func selectPicture( _ arg:Dictionary<String, Any> , handler: @escaping JSCallback){
        print(arg["count"]!)
        let maxSelection: Int = arg["count"] as! Int
         let config = PhotoPickerConfiguration(maxSelection: maxSelection, mediaType: .image) { (resources) in
            // 调整传递到js的数据格式
            var ImgPaths = [[String : Any]]()
            for asset in resources{
                let jsonbody : [String : Any] = ["path" : asset as! String]
                ImgPaths.append(jsonbody)
            }
            let tempFiles: [String: Any] = ["tempFiles" : ImgPaths]
            // 判断结构是否符合JSON转化标准
            if !JSONSerialization.isValidJSONObject(tempFiles) {
               print("数据结构错误")
               return
            }
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: tempFiles)
            handler(jsresult!)
         }
         let picker = PhotoPickerController(config: config)
         let crtvc = ViewControllerHelper.getTopMostViewController()
         crtvc?.present(picker, animated: true, completion: nil)
    }
    
    /*
     *  MARK: - 从相册选择 视频
    */
    @objc func selectVideo( _ arg:Any, handler: @escaping JSCallback){
        let config = PhotoPickerConfiguration(maxSelection: 10, mediaType: .video) { (resources) in
            // resources为选取的最终资源，图片或者视频的路径
            var VideoPaths = [[String : Any]]()
            for asset in resources{
                VideoPaths.append(asset as! [String : Any])
            }
            let tempFiles: [String: Any] = ["tempFiles" : VideoPaths]
            // 判断结构是否符合JSON转化标准
            if !JSONSerialization.isValidJSONObject(tempFiles) {
               print("数据结构错误")
               return
            }
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: tempFiles)
            handler(jsresult!)
        }
        let picker = PhotoPickerController(config: config)
        let crtvc = ViewControllerHelper.getTopMostViewController()
        crtvc?.present(picker, animated: true, completion: nil)
    }
    
   // MARK: - 拍照方法
   @objc func takePicture( _ arg:Any, handler: @escaping JSCallback){
        let vc = WMCameraViewController()
        vc.inputType = .image
        vc.modalPresentationStyle = .fullScreen
        vc.completeBlock = { url, type in
           if type == .image {
               let getImg = UIImage(contentsOfFile: url)
               // 权限验证判断函数
               self.photoAlbumPermissions(authorizedBlock: {
                   print("有相册访问权限")
                   //  保存图片到相册
                   PHPhotoLibrary.shared().performChanges({
                       let result = PHAssetChangeRequest.creationRequestForAsset(from: getImg!)
                       let assetPlaceholder = result.placeholderForCreatedAsset
                       //保存标志符
                       self.localId = assetPlaceholder?.localIdentifier
                   }) { (isSuccess: Bool, error: Error?) in
                       if isSuccess {
                        let filePath: String = url
                        // 截取文件名
                        let position2 = filePath.positionOf(sub: "/", backwards: true)
                        let fileName: String = String(filePath.suffix(filePath.count - position2 - 1));
                        print(fileName)
                        //  保存到沙盒文件中去
                        let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
                        let imageDePath = URL(fileURLWithPath: customPath).appendingPathComponent(fileName);
                        let data = NSData(contentsOf: URL(fileURLWithPath: url))
                        FileManager.default.createFile(atPath: imageDePath.path, contents: data as Data?, attributes: nil)
                        // 调整传递的数据格式
                        var ImgPaths = [[String : Any]]()
                        let jsonbody : [String : Any] = ["path" : imageDePath.path]
                        ImgPaths.append(jsonbody)
                        let tempFiles: [String: Any] = ["tempFiles" : ImgPaths]
                        // 判断结构是否符合JSON转化标准
                        if !JSONSerialization.isValidJSONObject(tempFiles) {
                           print("数据结构错误")
                           return
                        }
                        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: tempFiles)
                        handler(jsresult!)
                       } else{
                           print("保存失败：", error!.localizedDescription)
                       }
                   }
               }, deniedBlock: {
                   print("没有相册访问权限")
                   self.setAlbumPromissiom()
               })
           }
       }
       let crtvc = ViewControllerHelper.getTopMostViewController()
       crtvc?.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - 摄像方法
    @objc func takeVideo( _ arg:Any, handler: @escaping JSCallback) -> Void {
        let vc = WMCameraViewController()
        vc.inputType = .video
        vc.modalPresentationStyle = .fullScreen
        vc.completeBlock = { url, type in
            if type == .video {
                NSLog("拍摄的是视频")
                let videoEditer = WMVideoEditor.init(videoUrl: URL.init(fileURLWithPath: url))
                videoEditer.assetReaderExport(completeHandler: { url in
                     if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url) {
                        // 权限验证判断函数
                        self.photoAlbumPermissions(authorizedBlock: {
                            print("有相册访问权限")
                            // 保存视频到相簿
                            PHPhotoLibrary.shared().performChanges({
                                let result = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(string: url)!)
                                let assetPlaceholder = result?.placeholderForCreatedAsset
                                //保存标志符
                                self.localId = assetPlaceholder?.localIdentifier
                            }) { (isSuccess: Bool, error: Error?) in
                                if isSuccess {
                                    print("保存成功")
                                    // 生成视频截图
                                    let  videoURL =  URL (fileURLWithPath: url)
                                    let  avAsset =  AVAsset ( url : videoURL as URL)
                                    let  generator =  AVAssetImageGenerator (asset: avAsset)
                                    generator.appliesPreferredTrackTransform =  true
                                    let  time =  CMTimeMakeWithSeconds (0.0,preferredTimescale: 600)
                                    var  actualTime: CMTime  =  CMTimeMake (value: 0,timescale: 0)
                                    let  imageRef: CGImage  = try! generator.copyCGImage(at: time, actualTime: &actualTime)
                                    let  frameImg =  UIImage ( cgImage : imageRef)
                                    // 将UIImage格式缩略图转化为Data格式
                                    let IMGData = frameImg.jpegData(compressionQuality: 1)
                                    // 截取文件名
                                    let position1 = url.positionOf(sub: "/", backwards: true)
                                    let fileName: String = String(url.suffix(url.count - position1 - 1));
                                    print(fileName)
                                    // 生成缩略图名称
                                    let position2 = fileName.positionOf(sub: ".", backwards: true)
                                    var IMGName: String = String(fileName.prefix(position2))
                                    IMGName = IMGName + ".jpg"
                                    // 生成缩略图保存路径
                                    let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
                                    let thumbnilDirPath = customPath + "/thumb"
                                    // 创建文件夹路径
                                    let fileManager = FileManager.default
                                    if !fileManager.fileExists(atPath: thumbnilDirPath){
                                        do {
                                            try fileManager.createDirectory(atPath: thumbnilDirPath, withIntermediateDirectories: true, attributes: [:])
                                        } catch let error as NSError {
                                            print("Ooops! Something went wrong: \(error)")
                                        }
                                    }
                                    // 生成缩略图文件路径
                                    let thubfilePath = URL(fileURLWithPath: thumbnilDirPath).appendingPathComponent(IMGName).path;
                                    // 创建缩略图图片文件
                                    if !fileManager.fileExists(atPath: thubfilePath) {
                                        fileManager.createFile(atPath: thubfilePath, contents: IMGData, attributes: nil)
                                    }
                                    // 返回数据格式与安卓保持一致
                                    var jsonbody = [String : Any]()
                                    jsonbody["path"] = url
                                    jsonbody["compressPath"] = thubfilePath
                                    var VideoPaths = [[String : Any]]()
                                    VideoPaths.append(jsonbody)
                                    let tempFiles: [String: Any] = ["tempFiles" : VideoPaths]
                                    // 判断结构是否符合JSON转化标准
                                    if !JSONSerialization.isValidJSONObject(tempFiles) {
                                       print("数据结构错误")
                                       return
                                    }
                                    let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: tempFiles)
                                    handler(jsresult!)
                                } else{
                                    print("保存失败：", error!.localizedDescription)
                                }
                            }
                        },deniedBlock: {
                            print("没有相册访问权限")
                            self.setAlbumPromissiom()
                        })
                    }
                })
            }
        }
        
        let crtvc = ViewControllerHelper.getTopMostViewController()
        crtvc?.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - 将图片转化为Base64格式
    @objc func getLocalImgData( _ arg:Dictionary<String, Any> , handler: @escaping JSCallback) -> Void {
        let file = arg["localId"]
        let fileUrl = URL(fileURLWithPath: file as! String)
        let fileData = try! Data(contentsOf: fileUrl)
        //将图片转为base64编码
        let base64 = fileData.base64EncodedString(options: .endLineWithLineFeed)
        print(base64)
        let tempFiles: [String: Any] = ["localData" : base64]
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: tempFiles)
        handler(jsresult!)
    }
    
   
    
}

