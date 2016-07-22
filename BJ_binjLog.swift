//
//  BJ_binjLog.swift
//  BJLookupData
//
//  Created by binj on 16/6/17.
//  Copyright © 2016年 binj. All rights reserved.
//

import UIKit
import Foundation

func BJLog<binjClass>(message:binjClass, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    
    #ifDEBUG
        print("\((fileName as NSString).pathComponents.last):\(methodName)[\(lineNumber)]====\(message)")
    #endif
}
