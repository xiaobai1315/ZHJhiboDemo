//
//  UIColor+Extension.swift
//  HJZhiBo
//
//  Created by Jermy on 2018/8/14.
//  Copyright © 2018年 Jermy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(r: r / 255.0, g: g / 255.0, b: b / 255.0, alpha: alpha)
    }
    
    convenience init(rgb : CGFloat, alpha : CGFloat = 1.0) {
        self.init(r: rgb / 255.0, g: rgb / 255.0, b: rgb / 255.0, alpha: alpha)
    }
    
    //根据16进制字符串生成颜色，##FFFFFF、0XFFFFFF
    convenience init?(rgbHex : String, alpha : CGFloat = 1.0) {
        guard rgbHex.count >= 6 else {
            return nil
        }
        
        var tempHex = (rgbHex as NSString).uppercased
        
        if (tempHex.hasPrefix("##") || tempHex.hasPrefix("0X")) {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        
        if (tempHex.hasPrefix("#")) {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        
        range.location = 3
        let bHex = (tempHex as NSString).substring(with: range)
        
        var r : Int32 = 0, g : Int32 = 0, b : Int32 = 0
        Scanner(string: rHex).scanInt32(&r)
        Scanner(string: gHex).scanInt32(&g)
        Scanner(string: bHex).scanInt32(&b)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random() % 256), g: CGFloat(arc4random() % 256), b: CGFloat(arc4random() % 256))
    }
}
