//
//  JsResult.swift
//  mo-vol-ios
//
//  Created by 许永霖 on 2020/8/31.
//  Copyright © 2020 Gsafety. All rights reserved.
//

import Foundation
enum JsResultEnum: Int {
    case CODE_SUCCESS = 0
    case CODE_FAIL = 1
    case CODE_CANCEL = 2
    case CODE_TRIGGER = 3
    case CODE_REQUEST = 4
    /*下载状态回调*/
    case CODE_TASK_PRE = 10
    case CODE_TASK_START = 11
    case CODE_TASK_CANCEL = 12
    case CODE_TASK_RUNNING = 13
    case CODE_TASK_COMPLETE = 14
    case CODE_TASK_FAIL = 15
}
