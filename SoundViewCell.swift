//
//  SoundViewCell.swift
//  PrayerGod
//
//  Created by macOS on 15/06/23.
//

import UIKit


class SoundViewCell: UITableViewCell {
//MARK-> All @IBOutlet
    @IBOutlet weak var lbl_sound_name_list: UILabel!
   @IBOutlet weak var Cell_content_view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
