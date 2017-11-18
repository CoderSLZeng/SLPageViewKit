//
//  SLContentView.swift
//  SLPageViewKit_Example
//
//  Created by CoderSLZeng on 2017/11/17.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

protocol SLContentViewDelegate: class {
    func contentView(_ contentView: SLContentView, targetIndex: Int)
    func contentView(_ contentView: SLContentView, targetIndex: Int, progress: CGFloat)
}

class SLContentView: UIView {
    
    // MARK: 对外属性
    weak var delegate: SLContentViewDelegate?
    
    // MARK: 成员属性
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    
    fileprivate var startOffsetX: CGFloat = 0
    
    // MARK: lazy
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    
    
    // MARK: 构造方法
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
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
extension SLContentView {
    fileprivate func setupUI() {
        // 1.将childVc添加的父控制器中
        for vc in childVcs {
            parentVc.addChildViewController(vc)
            vc.view.backgroundColor = .randomColor()
        }
        
        // 2.初始化用于显示子控制器View的View（UIScrollView/UICollectionView）
        addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDataSource
extension SLContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let vc = childVcs[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SLContentView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let targetIndex = Int(scrollView.contentOffset.x / collectionView.bounds.width)
        delegate?.contentView(self, targetIndex: targetIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 1.定义获取需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        // 2.判断是左滑还说右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX { // 左滑
            
            sourceIndex = Int(startOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            progress = (currentOffsetX - startOffsetX) / scrollViewW
            
        } else { // 右滑
            
            sourceIndex = Int(startOffsetX / scrollViewW)
            targetIndex = sourceIndex - 1
            
            if targetIndex < 0 {
                targetIndex = 0
            }
            
            progress = (startOffsetX - currentOffsetX) / scrollViewW
        }
        
        delegate?.contentView(self, targetIndex: targetIndex, progress: progress)
    }
    
}

// MARK: - SLTitleViewDelegate
extension SLContentView: SLTitleViewDelegate {
    func titleView(_ titleView: SLTitleView, targetIndex: Int) {
        // 方式1
//        let offsetX = CGFloat(targetIndex) * collectionView.bounds.width
//        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
        // 方式2
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}

