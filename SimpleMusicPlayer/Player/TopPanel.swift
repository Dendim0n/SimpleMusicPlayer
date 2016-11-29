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
        let button = twitterButton(frame:CGRect.init(x: 0, y: 0, width: 25, height: 25))
//        button.frame = CGRect.zero
        button.imageSelectedColor = UIColor.init(red: 53.0/255.0, green: 131.0/255.0, blue: 215.0/255.0, alpha: 1)
        button.enableCustomImageSize = true
        button.explosionRate = 100
        button.setImage(UIImage.init(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(clicked(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var btnShare:twitterButton = {
        let button = twitterButton(frame:CGRect.init(x: 0, y: 0, width: 25, height: 25))
        button.imageSelectedColor = UIColor.init(red: 70.0/255.0, green: 197.0/255.0, blue: 85.0/255.0, alpha: 1)
        button.enableCustomImageSize = true
        button.explosionRate = 100
        button.setImage(UIImage.init(named: "smile"), for: .normal)
        button.addTarget(self, action: #selector(clicked(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var btnDownload:twitterButton = {
        let button = twitterButton(frame:CGRect.init(x: 0, y: 0, width: 25, height: 25))
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
        stack.spacing = 10
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

        buttonStackView.addArrangedSubview(btnPlay)
        buttonStackView.addArrangedSubview(btnShare)
        buttonStackView.addArrangedSubview(btnDownload)
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(150)
        }

    }

}
