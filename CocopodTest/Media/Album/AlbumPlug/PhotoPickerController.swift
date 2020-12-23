//
//  PhotoPickerController.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/9/27.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit
import Photos

/// 选取的资源类型
public enum PhotoPickerMediaType {
    case image
    case video
    case all
}

/// 图片选取器的配置
public struct PhotoPickerConfiguration {
    let maxSelection: Int
    let mediaType: PhotoPickerMediaType
    let completion: ((Array<Any?>) -> ())?
    public init(maxSelection: Int = 1, mediaType: PhotoPickerMediaType = .image, completion: ((Array<Any>) -> ())?) {
        self.maxSelection = maxSelection
        self.mediaType = mediaType
        self.completion = completion
    }
}

/// 图片选取器主类，继承自UINavigationController
public class PhotoPickerController: UINavigationController {
    let configuration: PhotoPickerConfiguration
    private var authorizationChecked: Bool = false
    
    public init(config: PhotoPickerConfiguration) {
        configuration = config
        super.init(nibName: nil, bundle: Bundle.main)
        setUpSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !authorizationChecked {
            authorizationChecked = true
            checkAuthorization()
        }
    }
    
    func checkAuthorization() {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { [unowned self] status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        self.setUpControllers()
                    default:
                        self.showNoAuthorizationAlert()
                    }
                }
            }
        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
            setUpControllers()
        } else {
            showNoAuthorizationAlert()
        }
    }
    
    func setUpSettings() {
        self.modalPresentationStyle = .fullScreen //全屏
        self.view.backgroundColor = .white
    }
    
    func setUpControllers() {
        var smartAlbumResult: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil) //All Photos
        if smartAlbumResult.count < 1 { //一般来说“All Photos”智能相册一定会有，但这里还是进行一下判断
            smartAlbumResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        }
        let assetListViewController = AssetListViewController.init(mediaType: configuration.mediaType) //list
        let assetCollectionViewController = AssetCollectionViewController.init(collection: smartAlbumResult.firstObject!, mediaType: configuration.mediaType)
        self.viewControllers = [assetListViewController, assetCollectionViewController]
    }
    
    func showNoAuthorizationAlert() {
        let alert = UIAlertController.init(title: NSLocalizedString("album_tips", comment: "提示"), message: NSLocalizedString("album_noPermissionPrompt", comment: "您未授权相册权限，请先到手机设置中开启相册权限"), preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("album_cancel", comment: "取消"), style: .default, handler: { [unowned self] action in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("album_settings", comment: "去设置"), style: .default, handler: { [unowned self] action in
            self.dismiss(animated: true) {
                if UIApplication.shared.canOpenURL(URL.init(string:UIApplication.openSettingsURLString)!) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(URL.init(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(URL.init(string:UIApplication.openSettingsURLString)!)
                    }
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showExceedMaxAlert() {
        
        let messages = String.localizedStringWithFormat( NSLocalizedString("album_maxSelectpictures", comment: "最多只能选取\(configuration.maxSelection)张图片") ,  configuration.maxSelection)
        
        let alert = UIAlertController.init(title: NSLocalizedString("album_tips", comment: "提示"), message: messages, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("album_confirm", comment: "确定"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func complete(selectedResources: [Any?]) {
        configuration.completion?(selectedResources)
        self.dismiss(animated: true, completion: nil)
    }

}

