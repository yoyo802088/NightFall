//
//  testViewController.swift
//  NightFall
//
//  Created by Yu-Shih Chen on 5/18/20.
//  Copyright © 2020 Yu-Shih Chen. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
@IBOutlet weak var testtxt: UILabel!
@IBOutlet weak var testbut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleFilledButton_1(testbut)
        Utilities.styleTextField(testtxt)
        //testbut.setTitleColor(UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1), for:.highlighted)
    }
    @IBAction func touchUp(sender: AnyObject){
        testbut.backgroundColor = UIColor(red: 0.929, green: 0.294, blue: 0.282, alpha: 1)
        testbut.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for:.normal)
    }
    @IBAction func touchDown(sender: AnyObject){
        testbut.backgroundColor = UIColor(red: 0.85, green: 0.29, blue: 0.28, alpha : 1)
        testbut.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for:.normal)
    }

}

