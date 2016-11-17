//
//  MusicPlayerController.swift
//  SimpleMusicPlayer
//
//  Created by 任岐鸣 on 2016/11/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 213/255.0, green: 253/255.0, blue: 1, alpha: 1)

        let player = MusicPlayer()
        view.addSubview(player)
        player.snp.makeConstraints { (make) in
            make.height.equalTo(500)
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
