//
//  Member.swift
//  Demo
//
//  Created by chen on 16/5/25.
//  Copyright © 2016年 ___CHEN___. All rights reserved.
//

import Foundation

class Member: NSObject {
    var name: String
    var mobile: String
    lazy var pinyinName: String = {
        return self.name.toPinyin()
    }()
    
    lazy var pinyinNameArray: [String] = {
        return self.pinyinName.componentsSeparatedByString(" ")
    }()
    
    lazy var pinyinNameAbbreviation: String = {
      return  self.pinyinNameArray.map { $0.fistLetter() }.joinWithSeparator("")
    }()
    
    init(name: String, mobile: String) {
        self.name = name
        self.mobile = mobile
    }
    
    
}

extension String {
    
    func toPinyin() -> String {
        
        let mutableString = NSMutableString(string: self) as CFMutableStringRef
        
        //带音调拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
            //不带音调拼音
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        
        var pinyin = mutableString as String
        pinyin = pinyin.stringByFoldingWithOptions(.CaseInsensitiveSearch, locale: NSLocale.currentLocale())
        
        pinyin = pinyin.stringByReplacingOccurrencesOfString("'", withString: "")
        return pinyin
    }
    
    
    func fistLetter() -> String {
        return self.substringToIndex(self.startIndex.advancedBy(1))
    }
}



