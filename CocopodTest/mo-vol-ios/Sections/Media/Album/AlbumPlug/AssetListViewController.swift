//
//  AssetListViewController.swift
//  
//  相册列表控制器
// Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit
import Photos

//注:若要相册名显示中文，需要在Info.plist->Localization native development region改为“China”
let AssetListCellIdentifier = "AssetListCellID"
let AssetListCellHeight = 60.0

/// 相册列表控制器
class AssetListViewController: UIViewController {
    let listView: UITableView = UITableView.init()
    var assetCollections: Array<PHAssetCollection> = []
    var mediaType: PhotoPickerMediaType = .image
    var hasLoadedCollections: Bool = false
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .gray)
    
    init(mediaType: PhotoPickerMediaType) {
        super.init(nibName: nil, bundle: Bundle.main)
        self.mediaType = mediaType
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationControllerSettings()
    }
    
    func setUp() {
        view.backgroundColor = .white
        listView.backgroundColor = .white
        listView.frame = UIScreen.main.bounds
        listView.dataSource = self
        listView.delegate = self
        listView.separatorStyle = .singleLine
        listView.register(AssetListCell.self, forCellReuseIdentifier: AssetListCellIdentifier)
        view.addSubview(listView)
        
        //loading
        var frame = loadingIndicator.frame
        frame.origin = CGPoint(x: (listView.frame.size.width - frame.size.width)/2.0, y: 10)
        loadingIndicator.frame = frame
        listView.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    func loadCollections() {
        guard !hasLoadedCollections else {
            return
        }
        hasLoadedCollections = true
        DispatchQueue.global().async { [unowned self] in
            let albumResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            let smartAlbumResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
            for result in [albumResult, smartAlbumResult] {
                for i in 0..<result.count {
                    let assetCollection = result[i] as PHAssetCollection
                    if assetCollection.assetCollectionSubtype == .smartAlbumUserLibrary { //"All Photos"显示在最上边
                        self.assetCollections.insert(assetCollection, at: 0)
                    } else {
                        let assets = PHAsset.fetchAssets(in: assetCollection, options: self.fetchOptions())
                        if assets.count > 0 {
                            self.assetCollections.append(assetCollection)
                        }
                    }
                    
                }
            }
            DispatchQueue.main.async {
                self.listView.reloadData()
                self.loadingIndicator.stopAnimating()
            }
        }
        
    }
    
    func fetchOptions() -> PHFetchOptions? {
        var options: PHFetchOptions? = PHFetchOptions.init()
        switch self.mediaType {
        case .image:
            options!.predicate = NSPredicate.init(format: "mediaType==\(PHAssetMediaType.image.rawValue)")
        case .video:
            options!.predicate = NSPredicate.init(format: "mediaType==\(PHAssetMediaType.video.rawValue)")
        case .all:
            options = nil
        }
        return options
    }
    
    func navigationControllerSettings() {
        if title == nil {
            title = NSLocalizedString("album_allPhotos", comment: "所有照片")
            let cancelButton = UIButton.init(type: .custom)
            cancelButton.setTitle(NSLocalizedString("album_cancel", comment: "取消"), for: .normal)
            cancelButton.setTitleColor(.black, for: .normal)
            cancelButton.sizeToFit()
            cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: cancelButton)
        }
    }
    
//MARK:- event
    @objc func cancelButtonClicked(sender: UIButton) {
        let picker = navigationController as! PhotoPickerController
        picker.complete(selectedResources: [])
    }
    
    deinit {
        assetCollections.removeAll()
    }
    
}

extension AssetListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assetCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listView.dequeueReusableCell(withIdentifier: AssetListCellIdentifier, for: indexPath) as! AssetListCell
        let collection = assetCollections[indexPath.row]
        let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions())
        let requestOptions = PHImageRequestOptions.init()
        requestOptions.resizeMode = .exact
        requestOptions.deliveryMode = .highQualityFormat
        PHImageManager.default().requestImage(for: assets.lastObject!, targetSize: CGSize(width: 180, height: 180), contentMode: .aspectFill, options: requestOptions) { (image, info) in
            cell.setData(thumbnail: image!, collectionName: collection.localizedTitle!, count: assets.count)
        }
    
        return cell
    }

}

extension AssetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AssetListCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listView.deselectRow(at: indexPath, animated: true)
        let picker = navigationController as! PhotoPickerController
        let collectionCtrl = AssetCollectionViewController.init(collection: assetCollections[indexPath.row], mediaType: picker.configuration.mediaType)
        navigationController?.pushViewController(collectionCtrl, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
