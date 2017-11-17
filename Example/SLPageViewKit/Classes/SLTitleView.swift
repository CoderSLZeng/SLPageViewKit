//
//  SLTitleView.swift
//  SLPageViewKit_Example
//
//  Created by CoderSLZeng on 2017/11/17.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class SLTitleView: UIView {

    // MARK: 成员属性
    fileprivate var titles: [String]
    fileprivate var style: SLtitleViewStyle
    
    // MARK: lazy
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    fileprivate lazy var titleLabels = [UILabel]()
    
    // MARK: 构造方法
    init(frame: CGRect, titles: [String], style: SLtitleViewStyle) {
        self.titles = titles
        self.style = style
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension SLTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        setupTitleLabel()
        setupTitleLabelFrame()
    }
    
    private func setupTitleLabel() {
        
        for (i, title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = style.titleFont
            titleLabel.textAlignment = .center
            
            titleLabel.tag = i
            
            scrollView.addSubview(titleLabel)
            
            titleLabels.append(titleLabel)
            
            titleLabel.backgroundColor = .randomColor()
        }
        
    }
    
    private func setupTitleLabelFrame() {
        let count = titleLabels.count
        
        for (i, label) in titleLabels.enumerated() {
            var w: CGFloat = 0
            let h: CGFloat = bounds.height
            var x: CGFloat = 0
            let y: CGFloat = 0
            
            if style.isScrollEnable { // 可以滚动
                // 根据Label的文字内容计算width
                w = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : style.titleFont], context: nil).width
                if i == 0 {
                    x = style.titleMargin * 0.5
                } else {
                    // 获取上一个Label
                    let preLabel = titleLabels[i - 1]
                    x = preLabel.frame.maxX + style.titleMargin
                }
            } else { // 不可以滚动
                w = bounds.width / CGFloat(count)
                x = w * CGFloat(i)
            }

            label.frame = CGRect(x: x, y: y, width: w, height: h)
            
            scrollView.contentSize = style.isScrollEnable ? CGSize(width: titleLabels.last!.frame.maxX + style.titleMargin * 0.5, height: 0) : CGSize.zero
            
        }
    }
}





