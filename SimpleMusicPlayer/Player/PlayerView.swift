//
//  PlayerView.swift
//  SimpleMusicPlayer
//
//  Created by 任岐鸣 on 2016/11/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    
    var audioPlayer = AVAudioPlayer()
    var isPlaying = true
    var lblTitle = UILabel()
    var lblArtist = UILabel()
    var imgCover = UIImageView()
    
    lazy var btnControl:PlayButton = {
        let button = PlayButton.init()
        button.initPlayButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(goPlay), for: UIControlEvents.touchUpInside)
        button.isUserInteractionEnabled = false
        button.alpha = 0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        setShadow()
        
        lblTitle.text = ""
        lblArtist.text = ""
        
        lblTitle.textColor = .white
        
        lblArtist.textColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.7)
        lblArtist.font = UIFont.systemFont(ofSize: 13)
        
        imgCover.isUserInteractionEnabled = true
        imgCover.image = UIImage.init(named: "cover.jpeg")
        
        
        self.backgroundColor = UIColor.init(red: 1, green: 93/255.0, blue: 104/255.0, alpha: 1)
        let bottomBlankView = UIView()
        addSubview(bottomBlankView)
        
        let topBlankView = UIView()
        addSubview(topBlankView)
        
        addSubview(lblTitle)
        addSubview(lblArtist)
        addSubview(imgCover)
        addSubview(btnControl)
        
        topBlankView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
            make.left.equalToSuperview()
            make.width.equalTo(1)
        }
        
        bottomBlankView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.left.equalToSuperview()
            make.width.equalTo(1)
        }
        imgCover.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottomBlankView.snp.top)
            make.height.equalToSuperview()
            make.width.equalTo(self.snp.height)
            make.left.equalToSuperview().offset(30)
        }
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalTo(topBlankView.snp.bottom)
            make.left.equalTo(imgCover.snp.right).offset(20)
            make.right.equalToSuperview()
        }
        lblArtist.snp.makeConstraints { (make) in
            make.left.equalTo(lblTitle)
//            make.top.equalTo(lblTitle.snp.bottom).offset(5)
            make.bottom.equalTo(imgCover).offset(-5)
            make.right.equalToSuperview()
        }
        
        btnControl.snp.makeConstraints { (make) in
            make.center.equalTo(imgCover)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    func setShadow() {
        self.backgroundColor = UIColor.init(red: 1, green: 93/255.0, blue: 104/255.0, alpha: 1)
        let color = self.backgroundColor
        self.backgroundColor = color
        self.layer.shadowColor = color?.cgColor
        self.layer.cornerRadius = 5
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 20
        
        imgCover.layer.shadowColor = UIColor.gray.cgColor
//        imgCover.layer.cornerRadius = 5
        imgCover.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        imgCover.layer.shadowOpacity = 1.0
        imgCover.layer.shadowRadius = 5
    }
    
    func goPlay() {
        if isPlaying {
            audioPlayer.pause()
            btnControl.setToPlay()
        } else {
            audioPlayer.play()
            btnControl.setToPause()
        }
        isPlaying = !isPlaying
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
//        playerLayer.frame = self.bounds
        btnControl.initPlayButton()
//        btnPrev.initPrevButton()
//        btnNext.initNextButton()
        
        layer.shadowPath = UIBezierPath.init(rect: CGRect.init(x: 20, y: self.bounds.size.height/2, width: self.bounds.size.width - (2*20), height: self.bounds.size.height/2)).cgPath
    }
}
