//
//  AssetPreviewController.swift
//  图片/视频预览控制器
//
//  Created by Layne on 2020/5/3.
//  Copyright © 2020 Layne. All rights reserved.
//

import UIKit
import Photos

let AssetPreviewCellIdentifier = "AssetPreviewCell"
let AssetPreviewEnterPointNone = -1

@objcMembers
class AssetPreviewController: UIViewController {
    var assetData: [PHAsset] = [] //所有asset数据
    //展示的数据范围：
    //1.预览进入的时候，assets = selectedAssets
    //2.点击某个cell进入的时候，assets = 0..<assetData.count,即为所有asset（的序号）
    var assets: [Int] = []
    dynamic var selectedAssets: [Int] = [] //KVO
    var contentCollectionView: UICollectionView!
    var navigationBarIsHidden: Bool = false //记录导航栏隐藏状态以便退出本页面时还原
    var enterPoint: Int = AssetPreviewEnterPointNone //点击进入的cell index。预览进入则使用AssetPreviewEnterPointNone
    var topView: AssetPreviewTopView!
    var bottomView: AssetActionView!
    var tapRecognizer: UITapGestureRecognizer!
    var useOriginal: Bool = false
    
    var backAction: (([Int], Bool) -> Void)?
    var completeAction: (([Int], Bool) -> Void)?
    
    var currentIndex: Int {
        let position = CGPoint(x: contentCollectionView.contentOffset.x + UIScreen.main.bounds.size.width / 2, y: 0)
        let current = contentCollectionView.indexPathForItem(at: position)!.row
        return current
    }
    
    init(enterPoint: Int, assetData: [PHAsset], assets: [Int], selectedAssets: [Int], useOriginal: Bool) {
        super.init(nibName: nil, bundle: Bundle.main)
        self.enterPoint = enterPoint
        self.assetData = assetData
        self.assets = assets
        self.selectedAssets  = selectedAssets
        self.useOriginal = useOriginal
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarIsHidden = navigationController!.navigationBar.isHidden
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = navigationBarIsHidden
        navigationItem.hidesBackButton = true //系统返回按钮会闪现，这里禁掉
    }
    
    func setUp() {
        view.backgroundColor = .black
        
        //collectionView
        let viewLayout = UICollectionViewFlowLayout.init()
        viewLayout.scrollDirection = .horizontal
        contentCollectionView = UICollectionView.init(frame: UIScreen.main.bounds, collectionViewLayout: viewLayout)
        contentCollectionView.backgroundColor = .black
        if #available(iOS 11.0, *) {
            contentCollectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        contentCollectionView.isPagingEnabled = true
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.register(AssetPreviewCell.self, forCellWithReuseIdentifier: AssetPreviewCellIdentifier)
        view.addSubview(contentCollectionView)
        
        //TopView
        topView = AssetPreviewTopView.init()
        topView.backAction = { [unowned self] in
            self.backAction?(self.selectedAssets, self.useOriginal)
            self.navigationController?.popViewController(animated: true)
        }
        topView.selectAction = { [unowned self] () -> Int in
            let index = self.assets[self.currentIndex]
            if let order = self.selectedAssets.lastIndex(of: index) { //操作为： 选中 -> 未选中
                self.selectedAssets.remove(at: order)
                return AssetCannotSelected
            } else { //操作为: 未选中 -> 选中
                let picker = self.navigationController as! PhotoPickerController
                if self.selectedAssets.count < picker.configuration.maxSelection {
                    self.selectedAssets.append(index)
                    return self.selectedAssets.count
                } else { //超限
                    picker.showExceedMaxAlert()
                    return AssetCannotSelected
                }
            }
            
        }
        
        if enterPoint != AssetPreviewEnterPointNone { //非预览进入(即点击某个cell进入)
            let index = enterPoint //点击某个cell进入，则enterPoint即为当前cell在整个相册中的索引
            if let order  = self.selectedAssets.lastIndex(of: index) { //为选中状态
                topView.updateData(order: order + 1)
            } else { //为未选中状态
                topView.updateData(order: AssetCannotSelected)
            }
        } else { //预览进入，则第一张展示的必为选中状态
            topView.updateData(order: 1)
        }
        self.view.addSubview(topView)
        
        //bottomView
        bottomView = AssetActionView.init(style: .dark)
        bottomView.previewButton.isHidden = true //隐藏预览按钮
        bottomView.useOriginalAction = {[unowned self] isUse in //使用原图
            self.useOriginal = isUse
        }
        bottomView.completeAction = {[unowned self] in //完成
            self.completeAction?(self.selectedAssets, self.useOriginal)
        }
        bottomView.updateUI(useOriginal: useOriginal,selectedCount: self.selectedAssets.count)
        view.addSubview(bottomView)
        
        //Tap
        tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent))
        contentCollectionView.addGestureRecognizer(tapRecognizer)
        
        if enterPoint != AssetPreviewEnterPointNone {//点击某个cell进入，需定位到点击的图片位置
            contentCollectionView.scrollToItem(at: IndexPath.init(row: enterPoint, section: 0), at: .right, animated: true)
        }
        
        self.addObserver(self, forKeyPath: "selectedAssets.@count", options: .new, context: nil)
    
    }
    
    func showOrHideActionView() {
        if topView.frame.origin.y < 0 {
            showActionView()
        } else {
            hideActionView()
        }
    }
    
    // 显示顶部和底部view
    func showActionView() {
        //top view
        var topViewFrame = topView.frame
        topViewFrame.origin.y = 0
        //bottomView
        var bottomViewFrame = bottomView.frame
        bottomViewFrame.origin.y = UIScreen.main.bounds.size.height - bottomViewFrame.size.height
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.topView.frame = topViewFrame
            self.bottomView.frame = bottomViewFrame
        }
    }
    
    // 隐藏顶部和底部view
    func hideActionView() {
        var topViewFrame = topView.frame
        topViewFrame.origin.y = -topViewFrame.height
        //bottomView
        var bottomViewFrame = bottomView.frame
        bottomViewFrame.origin.y = UIScreen.main.bounds.size.height
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.topView.frame = topViewFrame
            self.bottomView.frame = bottomViewFrame
        }
    }
    
    // 播放视频
    func playVideo(mode: VideoPlayMode) {
        let cell = contentCollectionView.visibleCells.first as? AssetPreviewCell
        cell?.playVideo(mode: mode)
    }
    
//MARK:- Tap
    @objc func tapEvent() {
        showOrHideActionView()
        playVideo(mode: .automic)
    }
    
    //MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        bottomView.updateUI(useOriginal: useOriginal, selectedCount: self.selectedAssets.count)
    }
    
    deinit {
        contentCollectionView.removeGestureRecognizer(tapRecognizer)
        self.removeObserver(self, forKeyPath: "selectedAssets.@count")
        assets.removeAll()
        selectedAssets.removeAll()
        backAction = nil
        completeAction = nil
    }
    
}

//MARK: - UICollectionViewDataSource
extension AssetPreviewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetPreviewCellIdentifier, for: indexPath) as! AssetPreviewCell
        
        let assetIndex = assets[indexPath.row]
        let asset = assetData[assetIndex]
        cell.setData(asset: asset)
        
        return cell
    }


}

//MARK: - UICollectionViewDelegate
extension AssetPreviewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension AssetPreviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension AssetPreviewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        showActionView()
        playVideo(mode: .pause)
        
        let index = self.assets[currentIndex]
        if let order  = self.selectedAssets.lastIndex(of: index) { //为选中状态
            topView.updateData(order: order + 1)
        } else { //为未选中状态
            topView.updateData(order: AssetCannotSelected)
        }
    }
}
