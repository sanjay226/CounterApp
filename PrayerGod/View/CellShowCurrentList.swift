//
//  CellShowCurrentList.swift
//  PrayerGod
//
//  Created by macOS on 05/05/23.
//

import UIKit

class CellShowCurrentList: UITableViewCell {
    
    @IBOutlet weak var lbl_mala_Count: UILabel!
    @IBOutlet weak var lbl_prabhuji_name: UILabel!
    @IBOutlet weak var lbl_Days_ago: UILabel!
    @IBOutlet weak var lbl_persenteg: UILabel!
    @IBOutlet weak var btn_opn_bottom_sheet: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

