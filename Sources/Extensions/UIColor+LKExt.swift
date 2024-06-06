//
//  UIColor+LKExt.swift
//
//
//  Created by 李棒棒 on 2024/6/6.
//

import Foundation
import UIKit

extension UIColor {
    
    /// 通过RGBA颜色值初始化对象
    /// - Parameter r: 红色通道值
    /// - Parameter g: 绿色通道值
    /// - Parameter b: 蓝色通道值
    /// - Parameter a: 透明度值，默认为1.0
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    
    public struct LK {
        
        ///从十六进制字符串获取颜色，
        ///color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
        public static func hex(_ hexString: String, alpha:CGFloat = 1.0) -> UIColor {
            //删除字符串中的空格
            var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // String should be 6 or 8 characters
            if cString.count < 6 { return UIColor.clear}
            
            // strip 0X if it appears
            //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
            let index = cString.index(cString.endIndex, offsetBy: -6)
            let subString = cString[index...]
            if cString.hasPrefix("0X") { cString = String(subString) }
            //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
            if cString.hasPrefix("#") { cString = String(subString) }
            
            if cString.count != 6 { return UIColor.clear }
            // Separate into r, g, b substrings
            var range: NSRange = NSMakeRange(0, 2)
            //r
            let rString = (cString as NSString).substring(with: range)
            
            //g
            range.location = 2
            let gString = (cString as NSString).substring(with: range)
            
            //b
            range.location = 4
            let bString = (cString as NSString).substring(with: range)
            
            // Scan values
            var r: UInt32 = 0x0
            var g: UInt32 = 0x0
            var b: UInt32 = 0x0
            
            Scanner(string: rString).scanHexInt32(&r)
            Scanner(string: gString).scanHexInt32(&g)
            Scanner(string: bString).scanHexInt32(&b)
            
            return UIColor(r: r, g: g, b: b, a:alpha)
        }
        
    }
    
}
