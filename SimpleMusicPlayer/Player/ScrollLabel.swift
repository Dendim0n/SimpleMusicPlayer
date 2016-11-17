//
//  ScrollLabel.swift
//  SimpleMusicPlayer
//
//  Created by 任岐鸣 on 2016/11/17.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class ScrollLabel: UIView,CAAnimationDelegate {
    
    var speed = 0.6

    lazy var label:UILabel = {
        let lbl = UILabel()
        lbl.sizeToFit()
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    let maskLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addAnim()
    }
    func setUI(){
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        maskLayer.path = UIBezierPath.init(rect: self.bounds).cgPath
        self.layer.mask = maskLayer
        
    }
    func addAnim() {
//        label  functionWithControlPoints:0 :0 :0.5 :0.5)
        let keyFrame = CAKeyframeAnimation()
        keyFrame.keyPath = "transform.translation.x"
        keyFrame.values = [0, -50, 0]
        keyFrame.repeatCount = Float(NSIntegerMax)
        keyFrame.duration = 5//self.speed * self.label.text.length
        keyFrame.timingFunctions = [CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction.init(controlPoints: 0, 0, 0.5, 0.5)];
        keyFrame.delegate = self
        label.layer.add(keyFrame, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
