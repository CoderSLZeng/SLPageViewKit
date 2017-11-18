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
    fileprivate var titles: [String]
    fileprivate var titleViewStyle: SLtitleViewStyle
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController

    // MARK: 构造方法
    init(frame: CGRect, titles: [String], titleViewStyle: SLtitleViewStyle, childVcs: [UIViewController], parentVc: UIViewController) {
        self.titles = titles
        self.titleViewStyle = titleViewStyle
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension SLPageView {
    
    fileprivate func setupUI() {
        // 1.添加标题视图
        let titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: titleViewStyle.titleViewHeight)
        let titleView = SLTitleView(frame: titleViewFrame, titles: titles, style: titleViewStyle)
        addSubview(titleView)
        
        // 2.添加内容视图
        let contentViewFrame = CGRect(x: 0, y: titleView.frame.maxY, width: bounds.width, height: frame.height - titleViewFrame.height)
        let contentView = SLContentView(frame: contentViewFrame, childVcs:childVcs, parentVc:parentVc)
        addSubview(contentView)
        
        
        // 设置代理
        titleView.delegate = contentView
    }
    
    
    
}







