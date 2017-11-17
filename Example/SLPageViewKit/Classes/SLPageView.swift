//
//  SLPageView.swift
//  SLPageViewKit_Example
//
//  Created by CoderSLZeng on 2017/11/17.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class SLPageView: UIView {

    // MARK: 成员属性
    fileprivate var style: SLPageStyle

    // MARK: 构造方法
    init(frame: CGRect, style: SLPageStyle) {
        
        self.style = style
        
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SLPageView {
    
    fileprivate func setupUI() {
        // 1.添加标题视图
        let titleViewFrame = CGRect(x: 0, y: 64, width: bounds.width, height: style.titleViewHeight)
        let titleView = SLTitleView(frame: titleViewFrame)
        addSubview(titleView)
        
        
        // 2.添加内容视图
        let contentViewFrame = CGRect(x: 0, y: titleView.frame.maxY, width: bounds.width, height: frame.height - titleViewFrame.height)
        let contentView = SLContentView(frame: contentViewFrame)
        addSubview(contentView)
        
        titleView.backgroundColor = UIColor(hex: "#ff7500")
        contentView.backgroundColor = UIColor(hex: "##c9dd22")
    }
    
    
    
}







