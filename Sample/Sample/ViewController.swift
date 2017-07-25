//
//  ViewController.swift
//  Sample
//
//  Created by Meniny on 2017-07-25.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import InfoPlist

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = InfoPlist.bundleDisplayName
    }

}

