//
//  WXXFileListViewController.swift
//  SandboxFileManager
//
//  Created by 田向阳 on 2017/8/17.
//  Copyright © 2017年 田向阳. All rights reserved.
//

import UIKit

class WXXFileListViewController: UIViewController {

    open var path: String = WXXFileServer.rootPath()
    private var dataArray: [WXXFileListModel]?
    private var isEdit: Bool = false
    
    var this = self
    
    public var fileCompleteBlock: (String) -> () = {_  in }

    //MARK: ControllerLifeCycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        initControllerFirstData()
        createUI()
        loadData()
        registNotification()
    }
    
    deinit {
//        print("dealloc:",self)
    }
    
    //MARK: LoadData
    private func loadData() {
        
        DispatchQueue.global().async {
            self.dataArray = WXXFileServer.getSubFolder(path: self.path)
            DispatchQueue.main.async {
                self.collectionView.fileListArray = self.dataArray;
                self.navigationItem.rightBarButtonItem?.isEnabled = (self.dataArray?.count ?? 0) > 0
            }
        }
    }
    
    private func initControllerFirstData() {
        self.navigationController?.isNavigationBarHidden = false
        if (navigationController?.viewControllers.count)! <= 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: NSLocalizedString("file_cancel", comment: "取消"), style: .plain, target: self, action: #selector(navigationItemLeftClick))
        }else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: NSLocalizedString("file_edit", comment: "编辑"), style: .plain, target: self, action: #selector(navigationItemRightClick))
        }
    }
    //MARK: Action
    @objc private func navigationItemLeftClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func navigationItemRightClick() {
        isEdit = !isEdit
        if isEdit {
            self.collectionView.startDeleteAnimation()
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: NSLocalizedString("file_complete", comment: "完成"), style: .plain, target: self, action: #selector(navigationItemRightClick))
        }else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: NSLocalizedString("file_edit", comment: "编辑"), style: .plain, target: self, action: #selector(navigationItemRightClick))
            self.collectionView.endShakeAnimation()
        }
        
    }
    
    //MARK: AddNotificatoin
    private func registNotification() {
        self.collectionView.didSelectRowBlock = {[weak self] (model: WXXFileListModel) in
            
            if model.fileType == .folder {
//                self?.fileCompleteBlock("url")
                let VC = WXXFileListViewController()
                VC.path = model.filePath
                VC.fileCompleteBlock = { url in
                    self?.fileCompleteBlock(url)
                }
                VC.title = model.fileName
                self?.navigationController?.pushViewController(VC, animated: true)
            }else{
                guard let self = self else { return }
//                let VC = WXXFilePreViewViewController()
                var array = [WXXFileListModel]()
                for fileModel in (self.dataArray)! {
                    if fileModel.fileType != .folder {
                        array.append(fileModel)
                    }
                }
                
                if array.firstIndex(of: model) != nil {
//                    VC.currentIndex = index
//                    VC.filePath = model.filePath
                    self.goBack(url: model.filePath)
                }
//                VC.fileArray = array
//                if #available(iOS 11.0, *) {
//                    let nav = UINavigationController.init(rootViewController: VC)
//                    self?.present(nav, animated: true, completion: nil)
//                } else {
//                    self?.present(VC, animated: true, completion: nil)
//                }
              
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
    
    func goBack(url: String) {
        self.fileCompleteBlock(url)
        navigationController?.popToRootViewController(animated:true)
//        self.dismiss(animated: true, completion: nil)
     }
    
    @objc private func appDidEnterBackground() {
        if isEdit {
            navigationItemRightClick()
        }
    }
    
    //MARK: CreateUI
    private func createUI() {
        view.addSubview(collectionView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(navigationItemLeftClick))
        tap.numberOfTapsRequired = 2
        tap.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(tap)
    }
    
    lazy var collectionView: WXXFileListCollectionView = {
        let collectionView = WXXFileListCollectionView()
        
        return collectionView
    }()
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    //MARK: Helper

}
