//
//  CameraControl.swift
//  mo-vol-ios
//
//  Created by Gsafety on 2020/12/4.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
import ContactsUI

public class ContactsControl: NSObject {
    
    var isAllowed:Bool = false
    typealias JSCallback = (Any)->Void

    public override init() {
        super.init()
    }
    
    
    // MARK: -  麦克风权限相关
    func contactPermissions() {
        //1.获取授权状态
        //CNContactStore 通讯录对象
        let contactstatus = CNContactStore.authorizationStatus(for: .contacts)
        // .notDetermined .authorized .restricted .denied
        if contactstatus == .notDetermined {
            // 第一次触发授权 alert
            CNContactStore().requestAccess(for: .contacts, completionHandler: { (isRight : Bool,error : Error?) in
                if isRight {
                    print("允许访问：")
                    self.isAllowed = true
                } else {
                    self.isAllowed = false
                }
            })
        } else if contactstatus == .authorized {
            self.isAllowed = true
        } else {
            self.isAllowed = false
        }
    }
    
    // MARK: -  搜索/查询联系人
    func getConcatsList( _ arg:Dictionary<String, Any>, callback: JSCallback) {
        print(arg)
        let searchData: String = arg["key"] as? String ?? ""
        contactPermissions()
        // 2.判断当前授权状态
        if !isAllowed {
            print("没录音权限")
            return
        }
        //3.创建通讯录对象
        let store = CNContactStore()
        //4.从通讯录中获取所有联系人
        //获取Fetch,并且指定之后要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey]
        //创建请求对象   需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        var phoneContacter = [Any]()
        //遍历所有联系人
        //需要传入一个CNContactFetchRequest
        do {
            try store.enumerateContacts(with: request, usingBlock: {(contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                var contactFlag = false  // 是否匹配查询标记
                //1.获取姓名
//                let lastName = contact.familyName
//                let firstName = contact.givenName
                let userName: String = contact.familyName + contact.givenName
                // *用户名匹配*
                if userName.contains(searchData) {
                    print(userName)
                    contactFlag = true
                }
                //2.获取电话号码
                var phones = [Any]()
                let phoneNumbers = contact.phoneNumbers
                for phoneNumber in phoneNumbers
                {
//                    let phoneLabel:String = phoneNumber.label ?? ""
                    // 获取电话号码并去掉中间空格
                    let Number:String = phoneNumber.value.stringValue.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    phones.append(Number)
                    // *电话号匹配*
                    if Number.contains(searchData) {
                        contactFlag = true
                    }
                }
                // 3.获取联系人ID
                let ID = contact.identifier
                let ContacterDic:[String:Any] = ["firstName": userName, "mobilePhoneNumber": phones, "ID": ID]
                // 4. 搜索关键字判断
                if searchData == "" {
                    phoneContacter.append(ContacterDic)
                } else if searchData != "" && contactFlag{
                    phoneContacter.append(ContacterDic)
                }
            })
        } catch {
            print(error)
        }
        callback(phoneContacter)
    }
    
    // MARK: - 新增联系人
    func addContact(contactModel:ContactModel) {
        //创建通讯录对象
        let store = CNContactStore()
         
        //创建CNMutableContact类型的实例
        let contactToAdd = CNMutableContact()
         
        //设置姓名
        contactToAdd.familyName = contactModel.firstName ?? ""
        let mobilePhoneNumber: [String] = contactModel.mobilePhoneNumber!
        var mobileValues = [CNLabeledValue<CNPhoneNumber>]()
        for phoneNumber in mobilePhoneNumber {
            //设置电话
            let mobileNumber = CNPhoneNumber(stringValue: phoneNumber)
            let mobileValue = CNLabeledValue(label: CNLabelPhoneNumberiPhone,
                                             value: mobileNumber)
            mobileValues.append(mobileValue)
        }
        contactToAdd.phoneNumbers = mobileValues
        //添加联系人请求
        let saveRequest = CNSaveRequest()
        saveRequest.add(contactToAdd, toContainerWithIdentifier: nil)
         
        do {
            //写入联系人
            try store.execute(saveRequest)
            print("保存成功!")
        } catch {
            print(error)
        }
    }
    // MARK: - 修改联系人信息
    // 目前有问题，不能修改电话号
    func editContact(contactModel:ContactModel) {
        //创建通讯录对象
        let store = CNContactStore()
        //获取Fetch,并且指定要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey]
        //创建请求对象，需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        //遍历所有联系人
        do {
            try store.enumerateContacts(with: request, usingBlock: {
                (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                 
                let contactToEdit = contact.mutableCopy() as! CNMutableContact
                // 获取 identifier
                let identifier = contactToEdit.identifier
                
                if contactModel.ID == identifier{
                    self.deleteContact(identifier)
                    self.addContact(contactModel: contactModel)
                }
            })
        } catch {
            print(error)
        }
    }
    // MARK:- 删除联系人
    func deleteContact(_ arg:Any) {
       //创建通讯录对象
       let store = CNContactStore()
       //获取Fetch,并且指定要获取联系人中的什么属性
       let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey]
       //创建请求对象，需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
       let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
       //遍历所有联系人
       do {
           try store.enumerateContacts(with: request, usingBlock: {
               (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
               let mutableContact = contact.mutableCopy() as! CNMutableContact
                // 获取 identifier
                let identifier = mutableContact.identifier
                if arg as! String == identifier{
                   //删除联系人请求
                   let request = CNSaveRequest()
                   request.delete(mutableContact)
                   do {
                       //执行操作
                       try store.execute(request)
                       print("删除成功!")
                   } catch {
                       print(error)
                   }
               }
           })
       } catch {
           print(error)
       }
   }
}
