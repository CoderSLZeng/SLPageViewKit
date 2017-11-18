//
//  ViewController.swift
//  SLPageViewKit
//
//  Created by CoderSLZeng on 11/17/2017.
//  Copyright (c) 2017 CoderSLZeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.pageView的Frame
        let pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 2.所有的标题
//        let titles = ["推荐", "视频", "直播", "娱乐"]
        let titles = ["推荐", "视频", "最热直播", "娱乐头条", "新闻", "段子", "美女", "科技"]
        
        // 3.标题视图样式
        let titleViewStyle = SLtitleViewStyle()
        titleViewStyle.titleViewHeight = 44
        titleViewStyle.isScrollEnable = true
        
        // 4.初始化所有子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = .randomColor()
            childVcs.append(vc)
        }
        
        let pageView = SLPageView(frame: pageViewFrame, titles: titles, titleViewStyle: titleViewStyle, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView);
    }

}

