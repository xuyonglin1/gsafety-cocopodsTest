//
//  XHNetwork.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/10/14.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class XHNetwork: NSObject {
    
    /**
     *  网络请求成功闭包:
     */
    typealias XHNetworkSuccess = (_ response:AnyObject) -> ()
    
    /**
     *  网络请求失败闭包:
     */
    typealias XHNetworkFailure = (_ error:NSError) -> ()
    
    /**
     *  上传进度闭包:(回调:1.单次上传大小 2.已经上传大小,3.文件总大小)
     */
    typealias UploadProgress = (_ bytesWritten: Int64,_ totalBytesWritten: Int64,_ totalBytesExpectedToWrite: Int64) -> ()
    
    /**
     *  下载进度闭包:(回调:1.单次写入大小 2.已经写入大小,3.文件总大小)
     */
    typealias DownloadProgress = (_ bytesRead:Int64,_ totalBytesRead:Int64,_ totalBytesExpectedToRead:Int64) -> ()
    
    /**
     *  网络请求单例
     */
    static let shareNetwork = XHNetwork()
    
}
