//
//  FileTransferApi.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/10/13.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire


class FileTransferApi: NSObject{

    typealias JSCallback = (Any)->Void
    /**
     *  网络请求成功闭包:
     */
    typealias XHNetworkSuccess = (_ response:Data) -> ()
    
    // MARK: - 文件上传方法
    // 必须使用"_"忽略第一个参数名
    @objc func uploadFile( _ args:Dictionary<String, Any>, handler: @escaping JSCallback){
        upload(url: args["url"]! as! String, fileURL: args["filePath"]! as! String, formData: args["formData"]!, success: {(success) in
            let valueArray = success as? [[String:Any]]
            let data = try? JSONSerialization.data(withJSONObject: valueArray as Any, options: [])
            let valueJson = String(data: data!, encoding: String.Encoding.utf8)
            let responseStr : [String:Any] = ["responseStr": valueJson as Any]
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_TASK_COMPLETE.rawValue, errMsg: "成功，OK", result: responseStr)
            print(jsresult!)
            handler(jsresult!)
        })
    }

    // MARK: - 文件下载方法
    @objc func downloadFile( _ args:Dictionary<String, Any>, handler: @escaping JSCallback){
        print("调用了下载方法")
        // 1. 得到文件名
        let filePath: String = args["filePath"] as! String
        let position2 = filePath.positionOf(sub: "/", backwards: true)
        let fileName: String = String(filePath.suffix(filePath.count - position2 - 1));
        print(fileName)
        // 2. 拼出本地沙盒存放路径
        let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let directoryPath = URL(fileURLWithPath: customPath).appendingPathComponent(fileName);
        // 3. 文件下载接口
        download(urlString: args["url"]! as! String,
            success: {(success) in
                let data = success
                FileManager.default.createFile(atPath: directoryPath.path, contents: data as Data?, attributes: nil)
                let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_TASK_COMPLETE.rawValue, errMsg: "成功，OK", result: directoryPath.path)
                print(jsresult!)
                handler(jsresult!)
        })
    }

    /**
    * 上传
    */
    func upload (url: String ,fileURL: String ,formData: Any ,success: @escaping JSCallback){
        let fileURLs: URL = URL(fileURLWithPath: fileURL)
        AF.upload(multipartFormData: {(multipartFormData) in
            multipartFormData.append(fileURLs, withName: "file")
        //            multipartFormData.append(formData, withName: "metadata")
        }, to: url).responseJSON { (response) in
            if let data = response.value {
                success(data)
            }
        }
    }

    /**
    * 文件下载
    */
    func download (urlString: String ,success: @escaping XHNetworkSuccess){
        AF.download(urlString).responseData { response in
            if let data = response.value {
                success(data)
            }
        }
    }
    
}
