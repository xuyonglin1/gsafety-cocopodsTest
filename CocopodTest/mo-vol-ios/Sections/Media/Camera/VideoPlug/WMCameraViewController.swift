//
//  WMCameraViewController.swift
//  WMVideo
//
//  Created by 许永霖 on 2020/8/12.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import UIKit
import AssetsLibrary
import AVFoundation
import Photos

enum WMCameraType {
    case video
    case image
    case imageAndVideo
}

class WMCameraViewController: UIViewController {
    
    var url: String?
    // output type
    var type: WMCameraType?
    // input tupe
    var inputType:WMCameraType = WMCameraType.imageAndVideo
    // record video max length
    var videoMaxLength: Double = 10
    
    
    var completeBlock: (String, WMCameraType) -> () = {_,_  in }
    
    let previewImageView = UIImageView()
    var videoPlayer: WMVideoPlayer!
    var controlView: WMCameraControl!
    var manager: WMCameraManger!
    
    let cameraContentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scale: CGFloat = 16.0 / 9.0
        let contentWidth = UIScreen.main.bounds.size.width
        let contentHeight = min(scale * contentWidth, UIScreen.main.bounds.size.height)
        
        cameraContentView.backgroundColor = UIColor.black
        cameraContentView.frame = CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight)
        cameraContentView.center = self.view.center
        self.view.addSubview(cameraContentView)
        
        manager = WMCameraManger(superView: cameraContentView)
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //MARK: - 权限判断
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        let audioAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        // .notDetermined .authorized .restricted .denied
        if videoAuthStatus == .notDetermined || audioAuthStatus == .notDetermined{
            self.manager.staruRunning()
            self.manager.focusAt(self.cameraContentView.center)
        } else if videoAuthStatus == .authorized && audioAuthStatus == .authorized{
            self.manager.staruRunning()
            self.manager.focusAt(self.cameraContentView.center)
        } else {
            if videoAuthStatus == .restricted || videoAuthStatus == .denied {
                setAlbumPromissiom("video")
            } else if audioAuthStatus == .restricted || audioAuthStatus == .denied {
                setAlbumPromissiom("audio")
            }
        }
    }
    
    // MARK: - 跳转 设置 相册访问权限（无权限时调用）
    func setAlbumPromissiom(_ type: String) {
        var alertMsg: String?
        if type ==  "video"{
            alertMsg = NSLocalizedString("album_noVideoPermission", comment: "请在iphone的“设置-隐私-相机”选项中，允许应用访问你的相机权限")
        } else if type ==  "audio"{
            alertMsg = NSLocalizedString("album_noAudioPermission", comment: "请在iphone的“设置-隐私-麦克风”选项中，允许应用访问你的麦克风权限")
        }
        let alertController = UIAlertController(title: nil,message: alertMsg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("album_cancel", comment: "取消"), style: .cancel, handler: {
            action in
            // 关闭当前相机窗口
            self.dismiss(animated: true, completion: nil)
        })
        let okAction = UIAlertAction(title: NSLocalizedString("album_settings", comment: "去设置"), style: .default, handler: {
            action in
            let settingUrl = NSURL(string: UIApplication.openSettingsURLString)!
            if UIApplication.shared.canOpenURL(settingUrl as URL)
            {
             UIApplication.shared.open(settingUrl as URL, options: [:], completionHandler: nil)
            }
            // 关闭当前相机窗口
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        let topvc = ViewControllerHelper.getTopMostViewController()
        topvc?.present(alertController, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.black
        cameraContentView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(focus(_:))))
        cameraContentView.addGestureRecognizer(UIPinchGestureRecognizer.init(target: self, action: #selector(pinch(_:))))
        
        videoPlayer = WMVideoPlayer(frame: cameraContentView.bounds)
        videoPlayer.isHidden = true
        cameraContentView.addSubview(videoPlayer)
        
        previewImageView.frame = cameraContentView.bounds
        previewImageView.backgroundColor = UIColor.black
        previewImageView.contentMode = .scaleAspectFit
        previewImageView.isHidden = true
        cameraContentView.addSubview(previewImageView)
        
        controlView = WMCameraControl.init(frame: CGRect(x: 0, y: cameraContentView.wm_height - 150, width: self.view.wm_width, height: 150))
        controlView.delegate = self
        controlView.videoLength = self.videoMaxLength
        controlView.inputType = self.inputType
        cameraContentView.addSubview(controlView)
    }
    
    @objc func focus(_ ges: UITapGestureRecognizer) {
        let focusPoint = ges.location(in: cameraContentView)
        manager.focusAt(focusPoint)
    }
    
    @objc func pinch(_ ges: UIPinchGestureRecognizer) {
        guard ges.numberOfTouches == 2 else { return }
        if ges.state == .began {
            manager.repareForZoom()
        }
        manager.zoom(Double(ges.scale))
    }
    
}

extension WMCameraViewController: WMCameraControlDelegate {
    
    func cameraControlDidComplete() {
        dismiss(animated: true) {
            self.completeBlock(self.url!, self.type!)
        }
    }
    
    func cameraControlDidTakePhoto() {
        manager.pickImage { [weak self] (imageUrl) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.type = .image
                self.url = imageUrl
                self.previewImageView.image = UIImage.init(contentsOfFile: imageUrl)
                self.previewImageView.isHidden = false
                self.controlView.showCompleteAnimation()
            }
        }
    }
    
    func cameraControlBeginTakeVideo() {
        manager.repareForZoom()
        manager.startRecordingVideo()
    }
    
    func cameraControlEndTakeVideo() {
        manager.endRecordingVideo { [weak self] (videoUrl) in
            guard let `self` = self else { return }
            let url = URL.init(fileURLWithPath: videoUrl)
            self.type = .video
            self.url = videoUrl
            self.videoPlayer.isHidden = false
            self.videoPlayer.videoUrl = url
            self.videoPlayer.play()
            self.controlView.showCompleteAnimation()
        }
    }
    
    func cameraControlDidChangeFocus(focus: Double) {
        let sh = Double(UIScreen.main.bounds.size.width) * 0.15
        let zoom = (focus / sh) + 1
        self.manager.zoom(zoom)
    }
    
    func cameraControlDidChangeCamera() {
        manager.changeCamera()
    }
    
    func cameraControlDidClickBack() {
        self.previewImageView.isHidden = true
        self.videoPlayer.isHidden = true
        self.videoPlayer.pause()
    }
    
    func cameraControlDidExit() {
        dismiss(animated: true, completion: nil)
    }
    
}
