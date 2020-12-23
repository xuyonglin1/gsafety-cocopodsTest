//
//  RecordApiSwift.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/12/1.
//  Copyright © 2020 Gsafety. All rights reserved.
//
import UIKit
import AVFoundation
//import AudioRecordToolKit



class RecordApiSwift: UIViewController{
    
//    let audioTool = AudioRecordTool()

    typealias JSCallback = (Any)->Void
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    }
    
    //  MARK: - 开始录音方法
    //  maxDuration: number, //录音最大时长
    //  mFlag: number, //录制格式，0：wav格式，1：pcm格式，2：mp3格式
    //  audioBitsPerSecond: number; //音频码率，默认是705.6kbps, 对应采样率是44100Hz，音频码率=采样率*位深度(16)*通道数（单通道1/双通道2）
    @objc func startRecord( _ arg:Dictionary<String, Any>, handler: @escaping JSCallback){
        print("开始录音")
//        print(arg)
        AudioRecordTool.sharedInstance.beforeRecord(arg["maxDuration"] as Any)
    }
    // MARK: - 暂停录音
    @objc func pauseRecord( _ arg:Any, handler: @escaping JSCallback){
        AudioRecordTool.sharedInstance.pauseRecord()
    }
    // MARK: - 恢复录音
    @objc func resumeRecoder( _ arg:Any, handler: @escaping JSCallback){
        AudioRecordTool.sharedInstance.resumeRecoder()
    }
    // MARK: - 停止录音
    @objc func stopRecord( _ arg:Any, handler: @escaping JSCallback){
        AudioRecordTool.sharedInstance.stopRecord()
    }
    // MARK: - 开始播放
    @objc func startPlay( _ arg:Any, handler: @escaping JSCallback){
        print("开始播放")
        AudioRecordTool.sharedInstance.startPlay()
    }
    // MARK: - 停止播放
    @objc func stopPlay( _ arg:Any, handler: @escaping JSCallback){
        print("停止播放")
        AudioRecordTool.sharedInstance.stopPlay()
    }
}
