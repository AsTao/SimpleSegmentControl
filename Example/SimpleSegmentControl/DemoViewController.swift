//
//  DemoViewController.swift
//  SimpleSegmentControl_Example
//
//  Created by Tao on 2018/6/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import SimpleSegmentControl

class DemoViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var segmentControl: SimpleSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentControl.segments = ["one","two","three"]
        segmentControl.reloadSegments()
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        self.segmentControl.indicatorOffsetX = scrollView.contentOffset.x/3;
        
    }

}
