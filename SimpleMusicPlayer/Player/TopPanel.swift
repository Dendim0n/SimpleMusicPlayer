//
//  TopPanel.swift
//  SimpleMusicPlayer
//
//  Created by 任岐鸣 on 2016/11/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class TopPanel: UIView {
    
    lazy var btnPlay:twitterButton = {
        let button = twitterButton(type:UIButtonType.custom)
        button.imageSelectedColor = UIColor.init(red: 53.0/255.0, green: 131.0/255.0, blue: 215.0/255.0, alpha: 1)
        button.enableCustomImageSize = true
        button.explosionRate = 100
        button.setImage(UIImage.init(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(clicked(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var btnShare:twitterButton = {
        let button = twitterButton(type:UIButtonType.custom)
        button.imageSelectedColor = UIColor.init(red: 70.0/255.0, green: 197.0/255.0, blue: 85.0/255.0, alpha: 1)
        button.enableCustomImageSize = true
        button.explosionRate = 100
        button.setImage(UIImage.init(named: "smile"), for: .normal)
        button.addTarget(self, action: #selector(clicked(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var btnDownload:twitterButton = {
        let button = twitterButton(type:UIButtonType.custom)
        button.imageSelectedColor = UIColor.init(red: 247.0/255.0, green: 158.0/255.0, blue: 16.0/255.0, alpha: 1)
        button.enableCustomImageSize = true
        button.explosionRate = 100
        button.setImage(UIImage.init(named: "star"), for: .normal)
        button.addTarget(self, action: #selector(clicked(sender:)), for: .touchUpInside)
        return button
    }()
    func clicked(sender:twitterButton){
        sender.isSelected = !sender.isSelected
    }
    var buttonStackView:UIStackView = {
        let stack = UIStackView()
        stack.alignment = UIStackViewAlignment.center
        stack.spacing = 15
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    init() {
        super.init(frame: CGRect.zero)
        setButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButton()
    }
    
    func setButton() {

        addSubview(btnPlay)
        addSubview(btnShare)
        addSubview(btnDownload)
//        
//        btnPlay.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.width.equalTo(btnShare)
//            make.right.equalTo(btnShare.snp.left)
//        }
//        btnShare.snp.makeConstraints { (make) in
//            make.left.equalTo(btnPlay.snp.right)
//            make.right.equalTo(btnDownload)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.width.equalTo(btnDownload.snp.left)
//        }
//        btnDownload.snp.makeConstraints { (make) in
//            make.right.equalToSuperview()
//            make.left.equalTo(btnShare.snp.right)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.width.equalTo(btnPlay)
//        }
    }

}
