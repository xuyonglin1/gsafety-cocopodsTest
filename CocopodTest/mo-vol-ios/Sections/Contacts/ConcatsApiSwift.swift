//
//  ConcatsApiSwift.swift
//  mo-vol-ios
//
//  Created by Gsafety on 2020/12/4.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
class ConcatsApiSwift: UIViewController {
    
    typealias JSCallback = (Any)->Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - 获取通讯录
    @objc func findPhoneConcat(_ arg:Dictionary<String, Any>, handler: @escaping JSCallback){
        let contactsControl = ContactsControl()
        contactsControl.getConcatsList(arg, callback: {(contacts) in
            let jsresult = JsResult().JsResult(code: JsResultEnum.CODE_SUCCESS.rawValue, errMsg: "成功，OK", result: contacts)
            print(jsresult!)
            handler(jsresult!)
        })
    }
    // MARK: - 新增联系人
    @objc func addPhoneContact(_ arg:Dictionary<String, Any>, handler: @escaping JSCallback){
        let contactModel:ContactModel = HandyJsonUtil.dictionaryToModel(arg["key"] as! Dictionary<String, Any>,ContactModel.self) as! ContactModel
        let contactsControl = ContactsControl()
        contactsControl.addContact(contactModel: contactModel)
    }
    // MARK: - 编辑联系人
    @objc func editPhoneContact(_ arg:Dictionary<String, Any>, handler: @escaping JSCallback){
        let contactModel:ContactModel = HandyJsonUtil.dictionaryToModel(arg["key"] as! Dictionary<String, Any>,ContactModel.self) as! ContactModel
        let contactsControl = ContactsControl()
        contactsControl.editContact(contactModel: contactModel)
    }
    // MARK: - 删除联系人
    @objc func deletePhoneContact(_ arg:Dictionary<String, Any>, handler: @escaping JSCallback){
        let contactsControl = ContactsControl()
        contactsControl.deleteContact(arg["key"] as Any)
    }
}
