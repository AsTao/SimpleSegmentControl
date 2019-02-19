//
//  ViewController.swift
//  SimpleSegmentControl
//
//  Created by tobias on 04/19/2018.
//  Copyright (c) 2018 ssTaoz. All rights reserved.
//

import UIKit
import SimpleSegmentControl

class ViewController: UIViewController {

  //  @IBOutlet weak var segmentControl: SimpleSegmentControl!
    
    lazy var segmentControl: SimpleSegmentControl = {
        let control = SimpleSegmentControl(frame: CGRect(x: 0, y: 100, width: self.view.frame.width , height: 70))
        control.backgroundColor = UIColor.white
        return control
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(segmentControl)
        segmentControl.segments = ["one","two","three"]
        //segmentControl.collectionSectionInset = UIEdgeInsetsMake(0, 50, 0, 50)
        
        segmentControl.indicatorInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        segmentControl.reloadSegments()
        segmentControl.indexChangedHandler = {   [weak self] index in
            print(index)
        }
        
 
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        print(sender.tag)
        segmentControl.selectedSegmentIndex = sender.tag
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

