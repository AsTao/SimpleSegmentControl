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

    @IBOutlet weak var segmentControl: SimpleSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentControl.segments = ["第一","第二","第三"]
        segmentControl.collectionSectionInset = UIEdgeInsetsMake(0, 50, 0, 50)
        segmentControl.reloadSegments()
        segmentControl.indexChangedHandler = {   [weak self] index in
            print(index)
        }
        
 
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

