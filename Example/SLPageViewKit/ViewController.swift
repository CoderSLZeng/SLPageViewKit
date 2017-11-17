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
        
        view.backgroundColor = UIColor(hex: "0xe0e0e8")
        // 1.pageView的Frame
        let pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 2.所有的标题
        let titles = ["推荐", "视频", "直播", "娱乐"]
        
        // 3.标题视图样式
        let pageStyle = SLtitleViewStyle()
        pageStyle.titleViewHeight = 44
        
        // 4.初始化所有子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = .randomColor()
            childVcs.append(vc)
        }
        let pageView = SLPageView(frame: pageViewFrame, pageStyle: pageStyle, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView);
    }

}

