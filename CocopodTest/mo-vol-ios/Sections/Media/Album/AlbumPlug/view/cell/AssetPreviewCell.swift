//
//  AssetPreviewCell.swift
//
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit
import Foundation
import Photos

enum VideoPlayMode {
    case play //播放
    case pause //暂停
    case automic //自动：播放时暂暂停，暂停是播放
}

class AssetPreviewCell: UICollectionViewCell {
    var data: PHAsset!
    var photoView = UIImageView.init()
    var zoomView = UIScrollView.init()
    lazy var playerIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "play_icon", in: PPUtil.frameworkBundle, compatibleWith: nil))
        view.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        view.isHidden = true
        return view
    }()
    lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.frame = UIScreen.main.bounds
        layer.videoGravity = .resizeAspectFill
        layer.isHidden = true
        return layer
    }()
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        photoView.frame = UIScreen.main.bounds
        photoView.contentMode = .scaleAspectFit
        photoView.backgroundColor = .black
        
        photoView.layer.addSublayer(playerLayer)
        photoView.addSubview(playerIcon)
        playerIcon.center = photoView.center
        
        zoomView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        zoomView.backgroundColor = .black
        zoomView.maximumZoomScale = 3
        zoomView.minimumZoomScale = 1
        zoomView.addSubview(photoView)
        zoomView.delegate  = self
    
        self.contentView.addSubview(zoomView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoFinishedPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        // 隐藏播放器元素
        player = nil
        playerItem = nil
        playerLayer.isHidden = true
        playerIcon.isHidden = true
        
        // 还原scale
        zoomView.zoomScale = 1.0
    }
    
    func setData(asset: PHAsset) {
        data = asset
        if asset.mediaType == .image { // image
            let options = PHImageRequestOptions()
            options.resizeMode = .none
            options.deliveryMode = .highQualityFormat
            options.isSynchronous = false
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options) { [unowned self](image, info) in
                if let image = image  {
                    self.photoView.image = image
                }
            }
            player = nil
            playerItem = nil
            playerLayer.isHidden = true
            playerIcon.isHidden = true
        } else { // video
            let options = PHVideoRequestOptions()
            options.version = .current
            options.deliveryMode =  .highQualityFormat
            PHImageManager.default().requestPlayerItem(forVideo: asset, options: options) { [unowned self](item, info) in
                if let playerItem = item {
                    self.playerItem = playerItem
                    self.player = AVPlayer(playerItem: self.playerItem)
                    self.playerLayer.player = self.player
                    self.playerLayer.isHidden = false
                    self.playerIcon.isHidden = false
                }
            }
   
        }
    }
    
    func playVideo(mode: VideoPlayMode) {
        guard data.mediaType == .video else {
            return
        }
        switch mode {
        case .play:
            if player?.rate == 0 {
                player?.play()
                playerIcon.isHidden = true
            }
        case .pause:
            if player?.rate != 0{
                player?.pause()
                playerIcon.isHidden = false
            }
        case .automic:
            if player?.rate == 0 {
                player?.play()
                playerIcon.isHidden = true
            } else {
                player?.pause()
                playerIcon.isHidden = false
            }
        }
    }
    
//MARK:- notification
    @objc func videoFinishedPlaying(notification: Notification) {
        // 循环播放
        if let item = notification.object as? AVPlayerItem, item == self.playerItem {
            playerItem?.seek(to: .zero, completionHandler: nil)
            player?.play()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension AssetPreviewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if data.mediaType != .image {
            return nil
        }
        return photoView
    }
}
