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
        
        view.backgroundColor = .randomColor()
        
        let style = SLPageStyle()
        style.titleViewHeight = 44
        
        let pageView = SLPageView(frame: view.bounds, style: style)
        view.addSubview(pageView);
    }

}

