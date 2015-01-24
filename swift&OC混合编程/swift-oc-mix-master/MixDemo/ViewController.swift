//
//  ViewController.swift
//  MixDemo
//
//  Created by  张正超 on 14/11/17.
//  Copyright (c) 2014年 zhengchaoZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var obj = OCChannel()
        obj.say();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func saysay(){
        println("swift")
    }

}

