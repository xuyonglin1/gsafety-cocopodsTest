//
//  AssetCollectionViewController.swift
//  
//  相册内图片Collection控制器
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit
import Photos

let AssetCollectionCellIdentifier = "AssetCollectionCell"
let AssetCollectionCellCountInSingleLine = 4 //单行cell个数
let AssetCollectionCellSpacing = 2 //item间距为2
let AssetCollectionActionViewHeight = 60.0 //底部功能区高度
let AssetCollectionCellChangeBlurNotification = "AssetCollectionCellChangeBlurNotification"

let AssetCannotSelected = 0

// 定义闭包类型
public typealias responseURL = ((_ responseURL : URL?) -> Void)

/// 一相册组中的所有照片
@objcMembers //KVO required
class AssetCollectionViewController: UIViewController {
    var assetCollecton: PHAssetCollection = PHAssetCollection.init()
    var mediaType: PhotoPickerMediaType = .image
    var assetCollectionView: UICollectionView!
    var actionView: AssetActionView! //底部功能区
    var assets: Array<PHAsset> = []
    var assetCellSize: CGSize { //单个cell的尺寸
        let screenWidth = UIScreen.main.bounds.size.width
        let totalSpacing = CGFloat((AssetCollectionCellCountInSingleLine - 1) * AssetCollectionCellSpacing)
        return CGSize(width: (screenWidth - totalSpacing)/CGFloat(AssetCollectionCellCountInSingleLine), height: (screenWidth - totalSpacing)/CGFloat(AssetCollectionCellCountInSingleLine))
    }
    var useOriginal: Bool = false //是否使用原图
    dynamic var selectedAssets: [Int] = [] //选取的图片的索引 dynamic: KVO required
    //定义闭包变量
    private var onResponseURL: responseURL?
    
    init(collection: PHAssetCollection, mediaType: PhotoPickerMediaType) {
        super.init(nibName: nil, bundle: Bundle.main)
        assetCollecton = collection
        self.mediaType = mediaType
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationControllerSettings()
        
    }
    
    func setUp() {
        view.backgroundColor = .white
        //collectionView
        let viewLayout = UICollectionViewFlowLayout.init()
        viewLayout.scrollDirection = .vertical
        
        var topInset = 64.0
        var bottomInset = 0.0
        if PPUtil.hasNotch {
            topInset = 88.0
            bottomInset = 34.0
        }
        
        let viewHeight = Double(UIScreen.main.bounds.size.height) - AssetCollectionActionViewHeight - topInset - bottomInset
        assetCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: topInset, width: Double(UIScreen.main.bounds.size.width), height: viewHeight), collectionViewLayout: viewLayout)
        assetCollectionView.backgroundColor = .white
        if #available(iOS 11.0, *) {
            assetCollectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        assetCollectionView.alwaysBounceVertical = true
        assetCollectionView.dataSource = self
        assetCollectionView.delegate = self
        assetCollectionView.register(AssetCollectionCell.self, forCellWithReuseIdentifier: AssetCollectionCellIdentifier)
        view.addSubview(assetCollectionView)
        
        loadData()

        if assets.count > 0 { //滚动到最底端
            assetCollectionView.scrollToItem(at: IndexPath.init(row: assets.count - 1, section: 0), at: .bottom, animated: true)
        }
        
        //ActionView
        actionView = AssetActionView.init()
        actionView.previewAction = {[unowned self] in //预览
            let previewController = AssetPreviewController.init(enterPoint: AssetPreviewEnterPointNone ,assetData: self.assets, assets: self.selectedAssets, selectedAssets: self.selectedAssets, useOriginal: self.useOriginal)
            previewController.backAction = { [unowned self] selected, useOriginal in
                self.useOriginal = useOriginal
                self.selectedAssets = selected
                self.assetCollectionView.reloadData()
            }
            previewController.completeAction = {[unowned self] selected, useOriginal in
                self.useOriginal = useOriginal
                self.selectedAssets = selected
                self.handleCompleteEvent()
            }
            self.navigationController?.pushViewController(previewController, animated: true)
        }
        actionView.useOriginalAction = {[unowned self] isUse in //使用原图
            self.useOriginal = isUse
        }
        actionView.completeAction = {[unowned self] in //完成
            self.handleCompleteEvent()
        }
        
        view.addSubview(actionView)
        
        self.addObserver(self, forKeyPath: "selectedAssets.@count", options: .new, context: nil)
    }
    
    func loadData() {
        var options: PHFetchOptions? = PHFetchOptions.init()
        switch mediaType {
        case .image:
            options!.predicate = NSPredicate.init(format: "mediaType==\(PHAssetMediaType.image.rawValue)")
        case .video:
            options!.predicate = NSPredicate.init(format: "mediaType==\(PHAssetMediaType.video.rawValue)")
        case .all:
            options = nil
        }
        
        let result = PHAsset.fetchAssets(in: assetCollecton, options: options)
        assets.removeAll()
        for i in 0..<result.count {
            let asset = result[i]
            assets.append(asset)
        }

    }
    
    func navigationControllerSettings() {
        if title == nil {
            title = assetCollecton.localizedTitle
            navigationItem.hidesBackButton = true
            
            //返回
            let backButton = UIButton.init(type: .custom)
            backButton.setTitle("   ", for: .normal)
            backButton.setImage(UIImage(named: "back_icon", in: PPUtil.frameworkBundle, compatibleWith: nil)!, for: .normal)
            backButton.sizeToFit()
            backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
            
            //取消
            let cancelButton = UIButton.init(type: .custom)
            cancelButton.setTitle(NSLocalizedString("album_cancel", comment: "取消"), for: .normal)
            cancelButton.setTitleColor(.black, for: .normal)
            cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: cancelButton)
        } 
    }
    
//MARK: - button action
    @objc func cancelButtonClicked(sender: UIButton) {
        let picker = navigationController as! PhotoPickerController
        picker.complete(selectedResources: [])
    }
    
    @objc func backButtonClicked(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
//MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        actionView.updateUI(useOriginal: useOriginal, selectedCount: self.selectedAssets.count)
    }
    
    //点击完成之后的处理逻辑
    func handleCompleteEvent() {
        let selectedResources: [Any?] = self.selectedAssets.map { (index) -> Any? in
                let asset = assets[index]
                //MARK: - 选择的是照片
                if asset.mediaType == .image {
                    var result : Any?
                    // 原始的暂时用不上的代码
                    let options = PHImageRequestOptions.init()
                    options.isSynchronous = true
                    options.isNetworkAccessAllowed = true
                    var targetSize = CGSize(width: 0, height: 0)
                    if useOriginal {
                        options.resizeMode = .none
                        options.deliveryMode = .highQualityFormat
                        targetSize = PHImageManagerMaximumSize
                    } else {
                        options.resizeMode = .fast
                        options.deliveryMode = .fastFormat
                        targetSize = CGSize(width: 1024, height: 1024)
                    }
                    
                    let assetResources = PHAssetResource.assetResources(for: asset)
                    var res: PHAssetResource?
                    for item in assetResources {
                        if item.type == .photo || item.type == .alternatePhoto {
                           res = item
                           break
                       }
                    }

                    guard let resource = res else {
                       return nil
                    }

                    let fileName = resource.originalFilename
                    let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
                    let filePath = URL(fileURLWithPath: customPath).appendingPathComponent(fileName);
                    
                    PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .default, options: options) { (image, info) in
                        let imageData = image!.jpegData(compressionQuality: 1) as NSData?
                        FileManager.default.createFile(atPath: filePath.path, contents: imageData as Data?, attributes: nil)
                    }
                    result = filePath.path
                    return result
                //MARK: - 选择的是视频
                } else if asset.mediaType == .video {
                    let assetResources = PHAssetResource.assetResources(for: asset)
                    var res: PHAssetResource?
                    for item in assetResources {
                       if item.type == .pairedVideo || item.type == .video {
                           res = item
                           break
                       }
                    }

                    guard let resource = res else {
                       return nil
                    }
                    let fileManager = FileManager.default
                    let fileName = resource.originalFilename
//                    var filePath: String? = PPUtil.CachesPath + "/\(fileName)"
                    let customPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
                    var filePath = URL(fileURLWithPath: customPath).appendingPathComponent(fileName).path;
                    // 将相册取出的视频保存至沙盒
                    if !fileManager.fileExists(atPath: filePath) {
                        PHAssetResourceManager.default().writeData(for: resource, toFile: URL(fileURLWithPath: filePath), options: nil) { (error) in
                            if error != nil {
                                filePath = "nil"
                            }
                        }
                    }
                    // 生成视频截图
                    let  videoURL =  URL (fileURLWithPath: filePath)
                    let  avAsset =  AVAsset ( url : videoURL as URL)
                    let  generator =  AVAssetImageGenerator (asset: avAsset)
                    generator.appliesPreferredTrackTransform =  true
                    let  time =  CMTimeMakeWithSeconds (0.0,preferredTimescale: 600)
                    var  actualTime: CMTime  =  CMTimeMake (value: 0,timescale: 0)
                    let  imageRef: CGImage  = try! generator.copyCGImage(at: time, actualTime: &actualTime)
                    let  frameImg =  UIImage ( cgImage : imageRef)
                    // 将UIImage格式缩略图转化为Data格式
                    let IMGData = frameImg.jpegData(compressionQuality: 1)
                    // 生成缩略图名称
                    let position2 = fileName.positionOf(sub: ".", backwards: true)
                    var IMGName: String = String(fileName.prefix(position2))
                    IMGName = IMGName + ".jpg"
                    // 生成缩略图保存路径
                    let thumbnilDirPath = customPath + "/thumb"
                    // 创建文件夹路径
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
                    var jsonbody = [String : Any]()
                    jsonbody["path"] = filePath
                    jsonbody["compressPath"] = thubfilePath
                    return jsonbody
                }
                return nil
        }
        let picker = self.navigationController as! PhotoPickerController
        picker.complete(selectedResources: selectedResources)
        
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "selectedAssets.@count")
        assets.removeAll()
        selectedAssets.removeAll()
    }

}

//MARK: - UICollectionViewDataSource
extension AssetCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCollectionCellIdentifier, for: indexPath) as! AssetCollectionCell
        cell.indexPathRow = indexPath.row
        let asset = self.assets[indexPath.row]
        let options = PHImageRequestOptions.init()
        options.resizeMode = .exact
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false
        //图片使用2x
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: assetCellSize.width * 2 , height: assetCellSize.height * 2), contentMode: .aspectFill, options: options) { (image, info) in
            if cell.indexPathRow == indexPath.row {
                cell.setPhoto(photo: image, isVideo: asset.mediaType == .video, videoDuration: asset.duration)
            }
        }
        cell.selectAction = { [unowned self]() -> (Bool, Int) in
            defer {
                let picker = self.navigationController as! PhotoPickerController
                if self.selectedAssets.count == picker.configuration.maxSelection {
                    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: AssetCollectionCellChangeBlurNotification), object: self.selectedAssets)
                }//启动模糊效果
                if self.selectedAssets.count == picker.configuration.maxSelection - 1 {
                    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: AssetCollectionCellChangeBlurNotification), object: nil)
                }//取消模糊效果
            }
            
            if let index = self.selectedAssets.lastIndex(of: indexPath.row) {//选中->未选中
                self.selectedAssets.remove(at: index)
                //更新其他cell的序号
                let indexPaths: [IndexPath] = self.selectedAssets.map { item -> IndexPath in
                    return IndexPath.init(row: item, section: 0)
                }
                
                self.assetCollectionView.reloadItems(at: indexPaths)
                return (toSelect: false, order: AssetCannotSelected) //取消选中
            } else { //将要选中
                let picker = self.navigationController as! PhotoPickerController
                if self.selectedAssets.count >= picker.configuration.maxSelection { //超限
                    picker.showExceedMaxAlert()
                    return (toSelect: true, order: AssetCannotSelected)
                } else {
                    self.selectedAssets.append(indexPath.row)
                    return (toSelect: true, order: self.selectedAssets.count)
                }
            }
        }
        //在滑动过程中点击返回，可能造成self已经出栈，即self.navigationController为nil，这里判断一下layne 2020-8-14
        if let naviController = self.navigationController {
            let picker = naviController as! PhotoPickerController
            if let order = self.selectedAssets.lastIndex(of: indexPath.row) {
                cell.update(order: order + 1, isBlur: false)
            } else {
                cell.update(order: AssetCannotSelected, isBlur: (self.selectedAssets.count == picker.configuration.maxSelection))
                
            }
        }

        return cell
    }

}

//MARK: - UICollectionViewDelegate
extension AssetCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assetsRange: [Int] = Array(0..<assets.count)
        let previewController = AssetPreviewController.init(enterPoint: indexPath.row ,assetData: assets, assets: assetsRange, selectedAssets: selectedAssets, useOriginal: useOriginal)
        previewController.backAction = { [unowned self] selected, useOriginal in
            self.useOriginal = useOriginal
            self.selectedAssets = selected
            self.assetCollectionView.reloadData()
        }
        previewController.completeAction = { [unowned self] selected, useOriginal in
            self.selectedAssets = selected
            self.useOriginal = useOriginal
            self.handleCompleteEvent()
            
        }
        self.navigationController?.pushViewController(previewController, animated: true)
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AssetCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return assetCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(AssetCollectionCellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


extension PHAsset {
 
    func getURL(complet : @escaping responseURL){
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                complet(contentEditingInput!.fullSizeImageURL as URL?)
            })
        } else if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    complet(localVideoUrl)
                } else {
                    complet(nil)
                }
            })
        }
    }
}
