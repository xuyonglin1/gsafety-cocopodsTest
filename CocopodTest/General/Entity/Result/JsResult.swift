//
//  Jsresult.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/31.
//  Copyright © 2020 Gsafety. All rights reserved.
//

class JsResult {
    
    public var code: Int?
    public var errMsg: String?
    public var result: Any?
    public var objName: Any?
    
    func JsResult(code: Int,errMsg: String) -> String?{
        self.code = code;
        self.errMsg = errMsg;var returnDict = [String: Any]()
        returnDict["code"] = String(code)
        returnDict["errMsg"] = String(errMsg)
        let dataString = HandyJsonUtil.dicToJson(returnDict)!
        return dataString
    }

    func JsResult(code: Int,errMsg: String,result: Any) -> Any?{
        self.code = code;
        self.errMsg = errMsg;
        self.result = result;
        var returnDict = [String: Any]()
        returnDict["code"] = String(code)
        returnDict["errMsg"] = String(errMsg)
        returnDict["result"] = result
        let dataString = HandyJsonUtil.dicToJson(returnDict)!
        return dataString
    }
}
