//
//  PlayerItemCell.swift
//  SimpleMusicPlayer
//
//  Created by 任岐鸣 on 2016/11/15.
//  Copyright © 2016年 Ned. All rights reserved.
//

import UIKit

class PlayerItemCell: UITableViewCell {
    
    var favClosure:((Void) -> Void)?

    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var imgFav: twitterButton!
    
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var lblTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        imgFav.enableCustomImageSize = true
        imgFav.explosionRate = 100
        imgFav.setImage(UIImage.init(named: "heart"), for: UIControlState.normal)
        imgFav.addTarget(self, action: #selector(clicked), for: UIControlEvents.touchUpInside)
        imgFav.isSelected = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func clicked() {
        imgFav.isSelected = !imgFav.isSelected
        favClosure?()
    }
}
