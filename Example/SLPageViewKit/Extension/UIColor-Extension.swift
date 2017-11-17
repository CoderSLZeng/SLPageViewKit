//
//  UIColor-Extension.swift
//  SLPageViewKit_Example
//
//  Created by CoderSLZeng on 2017/11/17.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0 , blue: b / 255.0, alpha: alpha)
    }
    
    
    /// 获取随机色方法
    ///
    /// - Returns: 随机色
    class func randomColor() -> UIColor {
        return UIColor.init(r: CGFloat(arc4random_uniform(256)),
                            g: CGFloat(arc4random_uniform(256)),
                            b: CGFloat(arc4random_uniform(256)))
    }
}
