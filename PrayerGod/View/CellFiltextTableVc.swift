//
//  CellFiltextTableVc.swift
//  PrayerGod
//
//  Created by macOS on 18/04/23.
//

import UIKit

class CellFiltextTableVc: UITableViewCell {
    //MARK: -   @IBOutlet
    @IBOutlet weak var lbl_lastTitle: UILabel!
    @IBOutlet weak var txtView_addText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
