//
//  HTAudioRecordTool.swift
//  mo-vol-ios
//
//  Created by Gsafety on 2020/12/1.
//  Copyright © 2020 Gsafety. All rights reserved.
//
// 参考：https://github.com/AliceHome/AudioRecordToolKit

import UIKit
import AVFoundation

public class AudioRecordTool: NSObject {
    
   
    var audioPlayer: AVAudioPlayer!
    
    //Audio
    var audioRecorder: AVAudioRecorder!
    let audioSession = AVAudioSession.sharedInstance()
    var isAllowed:Bool = false
    
    // Timer
    var count = 0
    let timer: DispatchSourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    
    let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0)),//声音采样率
        AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),//编码格式
        AVNumberOfChannelsKey : NSNumber(value: 1),//采集音轨
        AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue))]//音频质量
    
    // 单例模式
    static let sharedInstance1 = AudioRecordTool()
    //创建一个单例
    public class var sharedInstance : AudioRecordTool {
        return sharedInstance1
    }
    
    public override init() {
        super.init()
    }
    //MARK: audio init
    func createAudioRecorder() {
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioRecorder = AVAudioRecorder(url: self.ht_directoryURL(), settings: recordSettings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch let error {
            print(error)
        }
    }
    // MARK: -  麦克风权限相关
    func audioPermissions() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        // .notDetermined .authorized .restricted .denied
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            AVCaptureDevice.requestAccess(for: .audio,completionHandler: { (granted: Bool) in
                if granted {
                    print("允许访问：")
                    self.isAllowed = true
                } else {
                    self.isAllowed = false
                }
            })
        } else if authStatus == .authorized {
            self.isAllowed = true
        } else {
            self.isAllowed = false
            setAudioPromissiom()
        }
    }
    // 跳转 设置 相册访问权限（无权限时调用）
    func setAudioPromissiom() {
        let alertMsg = NSLocalizedString("album_noAudioPermission", comment: "请在iphone的“设置-隐私-麦克风”选项中，允许应用访问你的麦克风权限")
        let alertController = UIAlertController(title: nil,message: alertMsg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("album_cancel", comment: "取消"), style: .cancel, handler: {
            action in
        })
        let okAction = UIAlertAction(title:  NSLocalizedString("album_settings", comment: "去设置"), style: .default, handler: {
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

    //MARK: 录音相关
    
    //开始录音
    public func beforeRecord(_ arg:Any) {
        // 检查权限
        audioPermissions()
        createAudioRecorder()
        createTimer()
        timer.suspend()
        startRecord(arg)
    }
    public func startRecord(_ arg:Any) {
        if !isAllowed {
            print("没录音权限")
            return
        }
        // 如果正在播放，那么先停止当前的播放器
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        // 判断是否正在录音，如果没有那么开始录音
        if !audioRecorder.isRecording {
            do {
                try audioSession.setActive(true)
                audioRecorder.record(forDuration: arg as! TimeInterval)
                fireTimer()
            }catch let error {
                print(error)
            }
        }
    }
    //暂停录制
    func pauseRecord() {
        //  判断有无权限
        if !isAllowed {
            return
        }
        if audioRecorder.isRecording {
            print("暂停录音")
            audioRecorder.pause()
            pauseTimer()
        }
    }
    
    //恢复录制
    func resumeRecoder() {
        //  判断有无权限
        if !isAllowed {
            return
        }
        print("继续录音")
        audioRecorder.record()
        resumeTimer()
    }
    
    //停止录音
    public func stopRecord() {
        //  判断有无权限
        if !isAllowed {
            return
        }
        if audioRecorder.isRecording {
            audioRecorder.stop()
            print("停止录音")
            do {
                try audioSession.setActive(false)
                stopTimer()
            } catch let error {
                print(error)
            }
        }
    }
    
    //MARK: 播放相关
    //开始播放
    public func startPlay() {
        //  判断有无权限
        if !isAllowed {
            return
        }
        if !audioRecorder.isRecording {
            do {
                // 扬声器播放
                // try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                let url:URL? = audioRecorder.url
                print(url?.path ?? "aaaa")
                if let url = url {
                    try audioPlayer = AVAudioPlayer(contentsOf: url)
                    audioPlayer.delegate = self
                    audioPlayer.play()
                }
            } catch let error {
                print(error)
            }
        }
    }
    // 暂停播放
    public func pausePlay() {
        //  判断有无权限
        if !isAllowed {
            return
        }
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
            if !audioRecorder.isRecording {
                audioPlayer.pause()
            }
        }
    }
    // 停止播放
    public func stopPlay() {
        //  判断有无权限
        if !isAllowed {
            return
        }
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
            if !audioRecorder.isRecording {
                audioPlayer.stop()
            }
        }
    }
    
    
    //MARK: Timer
    func createTimer() {
        timer.schedule(wallDeadline: .now(), repeating: 1.0)
        timer.setEventHandler {
            print("timer")
            self.count = self.count + 1
            print(self.count)
        }
        timer.resume()
    }
    
    func fireTimer() {
        count = 0
        self.timer.resume()
    }
    
    func pauseTimer() {
        self.timer.suspend()
    }
    func resumeTimer() {
        self.timer.resume()
    }
    func stopTimer() {
        self.timer.suspend()
        count = 0
    }
    
    //获取默认文件存放地址
    func ht_directoryURL() -> URL {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyHHmmss"
        
        let recordingName = formatter.string(from: currentDateTime) + ".caf"
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = urls[0]
        let docDirFile = docDir.appendingPathComponent("record")
        let manager = FileManager.default
        // 使用文件管理对象，判断文件夹是否存在，并把结果储存在常量中
        let exist = manager.fileExists(atPath: docDirFile.path)
        // 如果文件夹不存在，则执行之后的代码
        if !exist {
            try? fileManager.createDirectory(atPath: docDirFile.path, withIntermediateDirectories: true, attributes: nil)
        }
        let soundURL = docDirFile.appendingPathComponent(recordingName)
        print(soundURL.path)
        return soundURL
    }
    
}

extension AudioRecordTool: AVAudioRecorderDelegate {
    
    /*
     录音停止、结束调用
     录音被打断不调用
     */
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorderDelegate-audioRecorderDidFinishRecording 录音结束")
        stopTimer()
    }
    
    
    /* 发生录音错误调用此方法 */
    public func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        
    }
    
    
    /* AVAudioRecorder INTERRUPTION NOTIFICATIONS ARE DEPRECATED - Use AVAudioSession instead. */
    
    /*录音被打断会调用 */
    public func audioRecorderBeginInterruption(_ recorder: AVAudioRecorder) {
        
    }
    
    
    /* audioRecorderEndInterruption:withOptions: is called when the audio session interruption has ended and this recorder had been interrupted while recording. */
    /* Currently the only flag is AVAudioSessionInterruptionFlags_ShouldResume. */
    public func audioRecorderEndInterruption(_ recorder: AVAudioRecorder, withOptions flags: Int) {
        
    }
}

extension AudioRecordTool: AVAudioPlayerDelegate {
    
}
