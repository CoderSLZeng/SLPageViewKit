//
//  SLTitleView.swift
//  SLPageViewKit_Example
//
//  Created by CoderSLZeng on 2017/11/17.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

protocol SLTitleViewDelegate: class  {
    
    func titleView(_ titleView: SLTitleView, targetIndex: Int)
}

class SLTitleView: UIView {
    // MARK: 对外属性
    weak var delegate: SLTitleViewDelegate?
    
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
    fileprivate lazy var currentIndex : Int = 0
    
    
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
            titleLabel.textColor = i == 0 ? style.selectedColor : style.normalColor
            
            
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            
//            titleLabel.backgroundColor = .randomColor()
            
            // 给titleLabel添加手势识别
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
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

// MARK: - action
extension SLTitleView {
    
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        // 1.取出用于点击的titleLabel
        let targetLabel = tapGes.view as! UILabel
        let sourceLabel = titleLabels[currentIndex]
        
        // 2.点击的titleLabel的下标
        let targetIndex = targetLabel.tag
        
        // 3.重复点击处理
        guard targetIndex != currentIndex else { return }
        
        // 4.切换状态颜色
        targetLabel.textColor = style.selectedColor
        sourceLabel.textColor = style.normalColor
        
        // 5.记录下标值
        currentIndex = targetIndex
        
        // 6.如果是不需要滚动,则不需要调整中间位置
        guard style.isScrollEnable else { return }
        
        // 6.计算和中间位置的偏移量
        var offsetX = targetLabel.center.x - bounds.width * 0.5
        
        // 7.边界处理
        if offsetX < 0 {
            offsetX = 0
        }
        let maxOffsetX = scrollView.contentSize.width - bounds.width
        if offsetX > scrollView.contentSize.width - bounds.width {
            offsetX = maxOffsetX
        }
        
        // 8.滚动UIScrollView
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        // 9.通知代理
        delegate?.titleView(self, targetIndex: targetIndex)
    }
}





