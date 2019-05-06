//
//  ViewController.swift
//  WaterPatternProject
//
//  Created by 仲召俊 on 2019/5/6.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    var waterPatternBtn: WaterPatternButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waterPatternBtn = WaterPatternButton(frame: CGRect(x: 50, y: ScreenSize.width, width: ScreenSize.width - 100, height: 50))
        waterPatternBtn.setTitle("登陆", for: .normal)
        waterPatternBtn.addTarget(self, action: #selector(btnClick(_:event:)), for: .touchUpInside)
        view.addSubview(waterPatternBtn)
    }
    
    @objc func btnClick(_ sender: UIButton, event: UIEvent) {
        let btn = sender as! WaterPatternButton
        btn.startButtonAnimation(sender, mevent: event)
    }
    
}

