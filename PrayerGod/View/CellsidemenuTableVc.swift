//
//  CellsidemenuTableVc.swift
//  PrayerGod
//
//  Created by macOS on 17/04/23.
//

import UIKit

class CellsidemenuTableVc: UITableViewCell {
    //MARK: -   @IBOutlet
    
    @IBOutlet weak var cell_view_contentview: UIView!
    @IBOutlet weak var img_Star_rate: UIImageView!
    @IBOutlet weak var lbl_Enable_disable: UILabel!
    @IBOutlet weak var lbl_notification: UILabel!
    @IBOutlet weak var switch_true_false_dynamicTuch: UISwitch!
    @IBOutlet weak var img_arrrow_next: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func switchChanged_true_false(_ sender: UISwitch) {
        if sender.isOn{
             UserDefaults.standard.set(true, forKey: "true")
            lbl_Enable_disable.text = "Enabled"
        }else{
            lbl_Enable_disable.text = "Disabled"
        }
    }
}
