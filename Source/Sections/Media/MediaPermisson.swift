//
//  MediaExtension.swift
//  mo-vol-ios
//
//  MARK: 本 MediaPermisson 专注于拓展 Media 的权限判断部分
//
//  Created by 许永霖 on 2020/11/25.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

extension MediaApiSwift{
    
    typealias OperationBlock = ()->Void
    
    // MARK: - 相册权限
    func photoAlbumPermissions(authorizedBlock: OperationBlock?, deniedBlock: OperationBlock?) {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            print("第一次触发授权：")
            PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) -> Void in
                if status == .authorized  {
                    print("允许访问：")
                    self.photoAlbumPermissions(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
                }
            }
        } else if authStatus == .authorized  {
            print("允许访问：")
            if authorizedBlock != nil {
                authorizedBlock!()
            }
        } else {
            print("拒绝访问：")
            if deniedBlock != nil {
                deniedBlock!()
            }
        }
    }
    
    // MARK: - 跳转 设置 相册访问权限（无权限时调用）
    func setAlbumPromissiom() {
        let alertController = UIAlertController(title: nil,message: "请在iphone的“设置-隐私-相册”选项中，允许应用访问你的相册", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
        })
        let okAction = UIAlertAction(title: "前往", style: .default, handler: {
            action in
            let settingUrl = NSURL(string: UIApplication.openSettingsURLString)!
            if UIApplication.shared.canOpenURL(settingUrl as URL)
            {
             UIApplication.shared.open(settingUrl as URL, options: [:], completionHandler: nil)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        let topvc = ViewControllerHelper.getTopMostViewController()
        topvc?.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: -  相机权限
    func cameraPermissions(authorizedBlock: OperationBlock?,deniedBlock: OperationBlock?) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        // .notDetermined .authorized .restricted .denied
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            AVCaptureDevice.requestAccess(for: .video,completionHandler: { (granted: Bool) in
                if granted {
                    print("允许访问：")
                    authorizedBlock!()
//            self.cameraPermissions(authorizedBlock: authorizedBlock,deniedBlock: deniedBlock)
                }
            })
        } else if authStatus == .authorized {
            if authorizedBlock != nil {
                authorizedBlock!()
            }
        } else {
            if deniedBlock != nil {
                deniedBlock!()
            }
        }
    }
    
    // MARK: -  麦克风权限
    func audioPermissions(authorizedBlock: OperationBlock?,deniedBlock: OperationBlock?) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        // .notDetermined .authorized .restricted .denied
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            AVCaptureDevice.requestAccess(for: .video,completionHandler: { (granted: Bool) in
                if granted {
                    print("允许访问：")
                    authorizedBlock!()
//                    self.audioPermissions(authorizedBlock: authorizedBlock,deniedBlock: deniedBlock)
                }
            })
        } else if authStatus == .authorized {
            if authorizedBlock != nil {
                authorizedBlock!()
            }
        } else {
            if deniedBlock != nil {
                deniedBlock!()
            }
        }
    }
}
