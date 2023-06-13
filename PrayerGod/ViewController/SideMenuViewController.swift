//
//  SideMenuViewController.swift
//  PrayerGod
//
//  Created by macOS on 17/04/23.
//

import UIKit

class SideMenuViewController: UIViewController {
//MARK: - All  @IBOutlet
    @IBOutlet weak var view_Addremove: UIView!
    @IBOutlet weak var tbl_Side_Menu: UITableView!
    var Arry_menu_list = [String]()
    //MARK: - Custem veriable
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_Side_Menu.delegate = self
        tbl_Side_Menu.dataSource = self
        Arry_menu_list = ["Notifications","Share App","Rate Us","Counter Sounds"]
    }
}
//MARK: - UITableViewDelegate, && UITableViewDataSource
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    Arry_menu_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tbl_Side_Menu.dequeueReusableCell(withIdentifier: "CellsidemenuTableVc", for: indexPath) as! CellsidemenuTableVc
        cell.lbl_notification.text = Arry_menu_list[indexPath.row]
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
