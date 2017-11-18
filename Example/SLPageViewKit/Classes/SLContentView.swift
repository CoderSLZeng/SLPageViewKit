//
//  SLContentView.swift
//  SLPageViewKit_Example
//
//  Created by CoderSLZeng on 2017/11/17.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

class SLContentView: UIView {

    // MARK: 成员属性
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    
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

