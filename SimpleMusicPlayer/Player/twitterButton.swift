//
//  LikeButton.swift
//  SimpleMusicPlayer
//
//  Created by 任岐鸣 on 2016/11/16.
//  Copyright © 2016年 Ned. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class twitterButton : UIButton {
    var imageSelectedColor:UIColor = UIColor.init(red: 221.0/255.0, green: 22.0/255.0, blue: 72.0/255.0, alpha: 1) {
        didSet {
            self.emitterImageView?.imageSelectedColor = imageSelectedColor
        }
    }
    var imageNormalColor:UIColor = .lightGray {
        didSet {
            self.emitterImageView?.imageNormalColor = imageNormalColor
        }
    }
    var explosionRate:Int = 0 {
        didSet {
            self.emitterImageView?.birthRate = explosionRate
        }
    }
    
    var enableCustomImageSize:Bool = true
    
    //    var Highlighted:Bool = false
    
    var disableAnimation:Bool = false{
        didSet {
            self.emitterImageView?.disableAnimation = disableAnimation
        }
    }
    
    override var isHighlighted:Bool {
        willSet {
            UIView.animate(withDuration: 0.3, animations: {
                if newValue {
                    self.alpha = 0.5
                } else {
                    self.alpha = 1
                }
            })
        }
    }
    
    override var isSelected: Bool {
        willSet {
            if self.isSelected == newValue {
                return
            }
            if newValue {
                emitterImageView?.select()
            } else {
                emitterImageView?.deselect()
            }
            print(newValue)
        }
    }
    
    private var emitterImageView:twitterEmitterImageView?
    private var image:UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func placeholderImage(image:UIImage) -> UIImage {
        var rect = self.bounds
        rect.size = image.size
        UIGraphicsBeginImageContext(rect.size)
        let path = UIBezierPath.init(ovalIn: rect)
        UIColor.clear.setFill()
        path.fill()
        let clearImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return clearImage!
    }
    
    func updateEmitter() {
        if self.image == nil {
            return
        }
        let imageScale = 0.65
        let imageSize = self.imageView!.bounds.size
        emitterImageView?.removeFromSuperview()
        emitterImageView = twitterEmitterImageView.init(frame: CGRect.init(x:0, y:0, width:ceil(Double(imageSize.width) / imageScale), height:ceil(Double(imageSize.height) / imageScale)))
        //        emitterImageView?.center = self.center
        self.emitterImageView?.disableAnimation = self.disableAnimation
        self.emitterImageView?.imageNormalColor = self.imageNormalColor
        self.emitterImageView?.imageSelectedColor = self.imageSelectedColor
        self.emitterImageView?.birthRate = self.explosionRate
        
        self.emitterImageView?.emitterImage = self.image!
        self.emitterImageView?.center = self.imageView!.center
        self.imageView?.clipsToBounds = false
        self.imageView?.addSubview(self.emitterImageView!)
        //        emitterImageView?.snp.makeConstraints { (make) in
        //            make.center.equalTo(self)
        //        }
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        self.emitterImageView?.center = self.imageView!.center
    }
    
    override func setImage(_ image: UIImage?, for state: UIControlState) {
        super.setImage(placeholderImage(image: image!), for: state)
        self.image = image!
        if !self.enableCustomImageSize {
            sizeToFit()
        }
        updateEmitter()
    }
}

class twitterEmitterImageView: UIImageView {
    
    let imageScale:CGFloat = 0.65
    
    lazy var circleShape:CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.frame = self.bounds
        let path = UIBezierPath.init(ovalIn: self.bounds)
        shape.fillColor = self.circleColor.cgColor
        shape.transform = CATransform3DMakeScale(0, 0, 1)
        shape.mask = self.circleMask
        shape.path = path.cgPath
        return shape
    }()
    
    lazy var circleMask:CAShapeLayer = {
        let shape = CAShapeLayer()
        
        shape.frame = self.bounds
        let path:UIBezierPath = UIBezierPath.init(ovalIn: self.bounds)
        path.addArc(withCenter: self.center, radius: 1, startAngle: 0, endAngle: 2.0*CGFloat(M_PI), clockwise: true)
        shape.path = path.cgPath
        shape.fillRule = kCAFillRuleEvenOdd
        
        return shape
    }()
    
    lazy var imageShape:CAShapeLayer = {
        let shape = CAShapeLayer()
        
        shape.frame = self.imageFrame()
        shape.position = self.center
        shape.fillColor = self.imageNormalColor.cgColor
        shape.path = UIBezierPath.init(rect: self.bounds).cgPath
        
        let maskLayer = CALayer()
        maskLayer.contents = UIImage.init(named: "like")?.cgImage
        maskLayer.frame = shape.bounds
        shape.mask = maskLayer
        
        return shape
    }()
    lazy var emitterLayer:CAEmitterLayer = {
        let emit = CAEmitterLayer()
        emit.emitterPosition = self.center
        emit.emitterSize = CGSize.init(width: self.bounds.size.width * 0.9, height: self.bounds.size.height * 0.9)
        emit.emitterMode = kCAEmitterLayerOutline
        emit.emitterShape = kCAEmitterLayerCircle
        emit.renderMode = kCAEmitterLayerAdditive
        emit.emitterCells = self.emitterCells()
        return emit
    }()
    
    var circleColor:UIColor {
        get {
            return self.imageSelectedColor
        }
    }
    var circleEndColor:UIColor{
        get {
            return self.imageSelectedColor
        }
    }
    var imageNormalColor:UIColor  = UIColor.lightGray {
        didSet {
            self.imageShape.fillColor = imageNormalColor.cgColor
        }
    }
    var imageSelectedColor:UIColor = UIColor.init(red: 221.0/255.0, green: 22.0/255.0, blue: 72.0/255.0, alpha: 1) {
        didSet {
            self.emitterLayer.emitterCells = self.emitterCells()
        }
    }
    
    var emitterImage:UIImage = UIImage() {
        didSet {
            self.imageShape.mask?.contents = emitterImage.cgImage
        }
    }
    
    var birthRate = 1
    var disableAnimation:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLayer() {
        layer.addSublayer(circleShape)
        layer.addSublayer(imageShape)
        layer.addSublayer(emitterLayer)
    }
    
    func select() {
        print("select")
        if disableAnimation {
            imageShape.fillColor = imageSelectedColor.cgColor
            return
        }
        
        let duration = 0.3
        let circleDelay = duration/2
        let maskDuration = duration - circleDelay
        let scale = self.bounds.size.width / 2 + 1
        
        let imageHideAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        imageHideAnimation.duration = duration / 3
        imageHideAnimation.toValue = 0
        imageHideAnimation.fillMode = kCAFillModeForwards
        imageHideAnimation.isRemovedOnCompletion = false
        
        imageShape.add(imageHideAnimation, forKey: "hide")
        
        imageShape.fillColor = imageSelectedColor.cgColor
        
        CATransaction.setAnimationDuration(duration)
        
        circleShape.transform = CATransform3DIdentity
        
        DispatchQueue.main.asyncAfter(deadline: .now() + circleDelay, execute: {
            CATransaction.setAnimationDuration(maskDuration)
            self.circleShape.mask?.transform = CATransform3DMakeScale(scale, scale, 1)
            self.circleShape.fillColor = self.circleEndColor.cgColor
            
            self.imageShape.animateWith(keypath: "transform.scale", from: 0, to: 1, duration: 1, delay: CGFloat(maskDuration / 2.0), damping: 7, velocity: 10, completion: nil)
            
            let emitterAnimation = CABasicAnimation.init(keyPath: "emitterCells.point.birthRate")
            emitterAnimation.beginTime = CACurrentMediaTime() + maskDuration / 2
            emitterAnimation.duration = 0.05
            emitterAnimation.fromValue = self.birthRate
            emitterAnimation.toValue = 0
            emitterAnimation.isRemovedOnCompletion = false
            emitterAnimation.fillMode = kCAFillModeForwards
            self.emitterLayer.add(emitterAnimation, forKey: "emitter")
        })
        
    }
    
    func deselect() {
        CATransaction.setDisableActions(true)
        circleShape.mask?.transform = CATransform3DIdentity
        circleShape.transform = CATransform3DMakeScale(0, 0, 1)
        circleShape.fillColor = circleColor.cgColor
        imageShape.fillColor = imageNormalColor.cgColor
        if !disableAnimation {
            imageShape.animateWith(keypath: "transform.scale", from: 1.3, to: 1, duration: 1, delay: 0, damping: 7, velocity: 10, completion: nil)
        }
    }
    
    func imageFrame() -> CGRect {
        let frame = self.bounds
        
        let rect = CGRect.init(x: frame.size.width / 2 - frame.size.width * imageScale / 2, y: frame.size.height / 2 - frame.size.height * imageScale / 2, width: frame.size.width * imageScale, height: frame.size.height * imageScale)
        
        return rect
    }
    
    func imageCenter() -> CGPoint {
        return CGPoint.init(x: self.imageFrame().midX, y: self.imageFrame().midY)
    }
    
    
    
    func emitterCells() -> Array<CAEmitterCell> {
        let emitterCell = CAEmitterCell()
        let duration:CGFloat = 0.5
        emitterCell.name = "point"
        emitterCell.birthRate = 0
        emitterCell.lifetime = Float(duration)
        
        emitterCell.velocity = self.bounds.size.width / 2
        
        emitterCell.scale = 0.1
        emitterCell.scaleSpeed = -(emitterCell.scale / duration)
        
        emitterCell.greenRange = 1
        emitterCell.redRange = 1
        emitterCell.blueRange = 1
        
        emitterCell.alphaRange = 1
        emitterCell.alphaSpeed = -(emitterCell.alphaRange / Float(duration))
        
        let rect = self.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        let path = UIBezierPath.init(ovalIn: rect)
        self.imageSelectedColor.setFill()
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        emitterCell.contents = image?.cgImage
        return [emitterCell]
    }
}

extension CALayer {
    func animateWith(keypath:String,from:CGFloat,to:CGFloat,duration:CGFloat,delay:CGFloat,damping:Double,velocity:Double,completion:((Void) -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        let animation = keyframeAnimationWith(keypath: keypath, from: from, to: to, duration: duration, damping: damping, velocity: velocity)
        animation.beginTime = CACurrentMediaTime() + Double(delay)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        add(animation, forKey: keypath)
        
        CATransaction.commit()
    }
    
    func keyframeAnimationWith(keypath:String,from:CGFloat,to:CGFloat,duration:CGFloat,damping:Double,velocity:Double) -> CAKeyframeAnimation {
        let values = animationValues(from: Double(from), to: Double(to), damping: damping, velocity: velocity)
        let animation = CAKeyframeAnimation.init(keyPath: keypath)
        animation.values = values
        animation.duration = CFTimeInterval(duration)
        return animation
    }
    
    func animationValues(from:Double,to:Double,damping:Double,velocity:Double) -> Array<Double> {
        let numberOfPoints = 500
        var values = Array<Double>()
        let delta = to - from
        for point in 0...numberOfPoints - 1 {
            let x = Double(point) / Double(numberOfPoints)
            let y = animationValuesNormalized(x: x, damping: damping, velocity: velocity)
            let value = to - delta * y
            values.append(value)
        }
        return values
    }
    
    func animationValuesNormalized(x:Double,damping:Double,velocity:Double) -> Double {
        return pow(M_E, -damping * x) * cos(velocity * x)
    }
}
