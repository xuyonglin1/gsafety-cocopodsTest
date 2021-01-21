//
//  WXXFilePreViewViewController.swift
//  SandboxFileManager
//
//  Created by 田向阳 on 2017/8/17.
//  Copyright © 2017年 田向阳. All rights reserved.
//

import UIKit
import QuickLook

class WXXFilePreViewViewController: UIViewController {

    open var filePath: String?//文件路径
    open var fileArray: [WXXFileListModel] = [WXXFileListModel]()
    open var currentIndex: Int = 0
    
    //MARK: ControllerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initControllerFirstData()
        createUI()
        loadData()
        registNotification()
    }
    // 结束时调用的函数
    deinit {
//        print("dealloc:",self)
    }
    //MARK: LoadData
    private func loadData() {
    }
    
    private func initControllerFirstData() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: NSLocalizedString("file_cancel", comment: "取消"), style: .plain, target: self, action: #selector(leftItemClick))
    }
    //MARK: Action
   @objc private func leftItemClick() {
        navigationController?.popViewController(animated:true)
    }
    
    
    //MARK: AddNotificatoin
    private func registNotification() {
    }
    //MARK: CreateUI
    private func createUI() {
        previewVC.delegate = self
        previewVC.dataSource = self
        previewVC.hidesBottomBarWhenPushed = true
        previewVC.view.backgroundColor = .red
        view.addSubview(previewVC.view)
//        previewVC.view.frame = self.view.bounds
        previewVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        previewVC.currentPreviewItemIndex = self.currentIndex
        self.addChild(previewVC)
    }
    
    lazy var previewVC: QLPreviewController = {
        let VC = QLPreviewController()
        return VC
    }()
    //MARK: Helper
}

extension WXXFilePreViewViewController: QLPreviewControllerDataSource, QLPreviewControllerDelegate {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
//        return self.fileArray.count
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
//        let model = self.fileArray[index]
        return  NSURL(fileURLWithPath: filePath ?? "")
    }
}
