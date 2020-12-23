//
//  FileApiSwift.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/10/9.
//  Copyright © 2020 Gsafety. All rights reserved.
//
//  参考：https://github.com/Cingjin/QuickLookDemo
//

import Foundation
import UIKit
import QuickLook


class FileApiSwift: UIViewController{
    

    typealias JSCallback = (Any)->Void
    
    var documentVC = UIDocumentInteractionController()
    
    // 预览控制
    fileprivate var preViewController = QLPreviewController.init()
    
    // 文件路径
//    fileprivate var filePath = Bundle.main.path(forResource: "test", ofType: ".html")
    fileprivate var filePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   // MARK: - 打开沙盒目录
   // 必须使用"_"忽略第一个参数名
    @objc func chooseFile( _ arg:Any, handler: @escaping JSCallback){
        let vc = WXXFileListViewController()
        vc.fileCompleteBlock = { url in
            let resUrl: String = url
            var resUrls = [String]()
            resUrls.append(resUrl)
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: resUrls)
            handler(jsresult!)
        }
        let crtvc = topViewController()
        crtvc?.navigationController?.pushViewController(vc, animated: true)
//        let nav = UINavigationController.init(rootViewController: vc)
//        nav.navigationBar.isTranslucent = false
//        let crtvc = topViewController()
//        crtvc?.present(nav, animated: true, completion: nil)
    }
    
    // MARK: - 文件预览
    @objc func openDocument( _ arg:Dictionary<String, Any>, handler: @escaping JSCallback){
        let vc = WXXFilePreViewViewController()
        let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let path: String = URL(fileURLWithPath: customPath).appendingPathComponent(arg["filePath"]! as! String).path;
        vc.modalPresentationStyle = .overFullScreen
        vc.filePath = path
        vc.currentIndex = 1
        let crtvc = topViewController()
        crtvc?.navigationController?.pushViewController(vc, animated: true)
        
//        let nav = UINavigationController.init(rootViewController: vc)
//        nav.navigationBar.isTranslucent = false
//        let crtvc = topViewController()
//        crtvc?.present(nav, animated: true, completion: nil)
    }
    // 判断文件是否存在 - 异步
    @objc func isFileExists( _ arg: Any, handler: @escaping JSCallback){
        let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let path: String = URL(fileURLWithPath: customPath).appendingPathComponent(arg as! String).path;
        let Exist: Bool = FileManager.default.fileExists(atPath: path)
        print(Exist)
//        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: Exist)
        handler(Exist)
    }
    // 判断文件是否存在 - 同步
    @objc func isFileExists_sync(_ arg: Any) -> Any {
        let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let path: String = URL(fileURLWithPath: customPath).appendingPathComponent(arg as! String).path;
        let Exist: Bool = FileManager.default.fileExists(atPath: path)
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: Exist)
        return jsresult!
    }
    // MARK: - 文件写入沙盒
    @objc func saveWithFile( _ arg:Any, handler: @escaping JSCallback){
//        let fileManager = FileManager.default
        let imagePath = Bundle.main.path(forResource: "123", ofType: "jpg")
        let imageData = NSData.init(contentsOfFile: imagePath!)
        let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let imageDePath = URL(fileURLWithPath: customPath).appendingPathComponent("123.jpg");
        print(imageDePath.path)
        if !FileManager.default.fileExists(atPath: imageDePath.path) {
            FileManager.default.createFile(atPath: imageDePath.path, contents: imageData as Data?, attributes: nil)
        }
    }
    
    // MARK: - 移除沙盒文件夹下所有文件
    @objc func deleteFileAtPath( _ arg:Any, handler: @escaping JSCallback){
        let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let fileManager = FileManager.default
        let enmerator = fileManager.enumerator(atPath: customPath)
        for fileName in enmerator! {
            let filePath = customPath.appendingFormat("/\(fileName)")
            try! fileManager.removeItem(atPath: filePath)
        }
    }
    // MARK: - 获取文件属性信息
    @objc func getSavedFileInfo( _ arg:Any, handler: @escaping JSCallback){
        let filePath: String = arg as! String
        let manager = FileManager.default
        let attributes = try? manager.attributesOfItem(atPath: filePath) //结果为Dictionary类型
        print("修改时间：\(attributes![FileAttributeKey.modificationDate]!)")
        print("文件大小：\(attributes![FileAttributeKey.size]!)")
        let lastModifiedTime = attributes![FileAttributeKey.modificationDate]! as! Date
        let formatter = DateFormatter()
        //然后再次设置您需要使用哪种格式的输出类型
        formatter.dateFormat = "yyyy-MM-dd HH：mm：ss"
        //再次将日期转换为字符串
        let myStringafd = formatter.string(from:lastModifiedTime)
        let result:[String:Any] = ["size":attributes![FileAttributeKey.size]!, "lastModifiedTime": myStringafd]
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: result)
        handler(jsresult!)
    }
    @objc func getSavedFileInfo_sync(_ arg: Any) -> Any {
        let filePath: String = arg as! String
        let manager = FileManager.default
        let attributes = try? manager.attributesOfItem(atPath: filePath) //结果为Dictionary类型
        print("修改时间：\(attributes![FileAttributeKey.modificationDate]!)")
        print("文件大小：\(attributes![FileAttributeKey.size]!)")
        let lastModifiedTime = attributes![FileAttributeKey.modificationDate]! as! Date
        let formatter = DateFormatter()
        //然后再次设置您需要使用哪种格式的输出类型
        formatter.dateFormat = "yyyy-MM-dd HH：mm：ss"
        //再次将日期转换为字符串
        let myStringafd = formatter.string(from:lastModifiedTime)
        print(myStringafd)
        let result: [String: Any] = ["size" : attributes![FileAttributeKey.size]!, "lastModifiedTime":myStringafd]
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: result)
        return jsresult as Any
    }
    // MARK: - 计算文件或文件夹的大小
    @objc func getfileSize( _ arg:Any, handler: @escaping JSCallback){
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let resultSize =  Self.getFileSizeByPath(folderPath: filePath)
        let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: resultSize)
        handler(jsresult!)
    }
    //获取文件大小
    class func getFileSizeByPath(folderPath: String)-> String{
        if folderPath.count == 0 {
            return "0MB" as String
        }
        let manager = FileManager.default
        if !manager.fileExists(atPath: folderPath){
            return "0MB" as String
        }
        var fileSize:Float = 0.0
        do {
            let files = try manager.contentsOfDirectory(atPath: folderPath)
            for file in files {
                let path = folderPath + "/" + file
                fileSize = fileSize + fileSizeAtPath(filePath: path)
            }
        }catch{
            fileSize = fileSize + fileSizeAtPath(filePath: folderPath)
        }
        var resultSize = ""
        if fileSize >= 1024.0*1024.0{
            resultSize = NSString(format: "%.2fMB", fileSize/(1024.0 * 1024.0)) as String
        }else if fileSize >= 1024.0{
            resultSize = NSString(format: "%.fkb", fileSize/(1024.0 )) as String
        }else{
            resultSize = NSString(format: "%llub", fileSize) as String
        }
        
        return resultSize
    }
    /**  计算单个文件或文件夹的大小 */
    class func fileSizeAtPath(filePath:String) -> Float {
        let manager = FileManager.default
        var fileSize:Float = 0.0
        if manager.fileExists(atPath: filePath) {
            do {
                let attributes = try manager.attributesOfItem(atPath: filePath)
                if attributes.count != 0 {
                    fileSize = attributes[FileAttributeKey.size]! as! Float
                }
            }catch{
            }
        }
        return fileSize;
    }
    //  *******获取文件大小结束**********
}

