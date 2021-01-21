//
//  MessageViewController.swift
//  mo-vol-ios
//
//  发送短信功能
//
//  Created by Gsafety on 2020/12/10.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import AVFoundation
import MessageUI

public class MessageController: NSObject ,MFMessageComposeViewControllerDelegate {
    
    func sendMessage( _ arg: Any){
        //首先要判断设备具不具备发送短信功能
        if MFMessageComposeViewController.canSendText(){
            let vc = MFMessageComposeViewController()
            //设置短信内容
            vc.body = "短信发送功能测试 —— BY 许永霖"
            //设置收件人列表
            vc.recipients = ["13720363543"]
            //设置代理
            vc.messageComposeDelegate = self
            //打开界面
            let crtvc = ViewControllerHelper.getTopMostViewController()
            crtvc?.present(vc, animated: true, completion: nil)
        } else{
            print("本设备不能发送短信")
        }
    }
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
            case MessageComposeResult.sent.rawValue:
                print("短信已发送")
            case MessageComposeResult.cancelled.rawValue:
                print("短信取消发送")
            case MessageComposeResult.failed.rawValue:
                print("短信发送失败")
            default:
                break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
