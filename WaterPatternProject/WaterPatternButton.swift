//
//  WaterPatternButton.swift
//  WaterPatternProject
//
//  Created by 仲召俊 on 2019/5/6.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///水纹按钮
class WaterPatternButton: UIButton {

    //MARK: - 定义属性
    
    ///当前点击点的x坐标
    var circleCenterX:CGFloat = 0
    ///当前点击点的y坐标
    var circleCenterY:CGFloat = 0
    ///定时器
    var timer:Timer!
    ///定时器刷新方法初始值
    var countNum:Int = 0
    ///当前圆形半径
    var viewRadius: CGFloat = 0
    ///当前动画绘制颜色
    var targetAnimColor = RGBAColor(216,114,213,0.8)
    
    //MARK: - Function
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = RGBColor(50,185,170)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///绘制圆形
    override func draw(_ rect: CGRect) {
        //获取当前绘制上下文的context
        let context = UIGraphicsGetCurrentContext()
        //设置绘制的角度为360度
        let endAngle = CGFloat(Double.pi*2)
        //使用addArc方法绘制圆形
        context?.addArc(center: CGPoint(x: circleCenterX, y: circleCenterY), radius: viewRadius, startAngle: 0, endAngle: endAngle, clockwise: false)
        //获取当前动画绘制颜色
        let stockColor:UIColor = targetAnimColor
        //填充当前圆形的内部颜色和边缘颜色
        stockColor.setStroke()
        stockColor.setFill()
        //完成圆形绘制
        context?.fillPath()
    }
    
    ///开启水纹动画
    func startButtonAnimation(_ msenderBtn: UIButton, mevent: UIEvent) {
        //设置状态为不可点击
        isUserInteractionEnabled = false
        //将传递来的按钮向上转型为UIView
        let button = msenderBtn as UIView
        //获取当前event事件在UIView的事件集
        let touchSet = mevent.touches(for: button)! as NSSet
        //获取当前点击的所有事件对象
        let touchArr = touchSet.allObjects as [AnyObject]
        //获取第一个点击事件的UITouch对象
        let touch1 = touchArr[0] as! UITouch
        //获取当前点击的UITouch对象在button中的位置
        let point1 = touch1.location(in: button)
        //获取当前点击点的x、y坐标
        circleCenterX = point1.x
        circleCenterY = point1.y
        //实例化定时器用于定时刷新button的水纹动画，并添加到RunLoop中
        timer = Timer(timeInterval: 0.02, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }

    ///定时器刷新方法
    @objc func timeAction() {
        countNum += 1
        //获取一个dismissTime时间，这里将时间设置为0
        let dismissTime:DispatchTime = DispatchTime.now() + Double(Int64(0*NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        //在主线程中增加圆形半径（+5），并调用setNeedsDisplay()方法出发draw完成重绘
        DispatchQueue.main.asyncAfter(deadline: dismissTime) {
            self.viewRadius += 5
            self.setNeedsDisplay()
        }
        //判断该方法被调用50次之后，清空countNum和viewRadius，并使定时器失效
        if countNum > 50 {
            countNum = 0
            viewRadius = 0
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: dismissTime) {
                self.viewRadius = 0
                self.setNeedsDisplay()
            }
        }
        //最后使能button
        isUserInteractionEnabled = true
    }
}
