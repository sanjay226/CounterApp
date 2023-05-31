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
    //MARK: - Custem veriable
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_Side_Menu.delegate = self
        tbl_Side_Menu.dataSource = self
       
    }
}
//MARK: - UITableViewDelegate, && UITableViewDataSource
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tbl_Side_Menu.dequeueReusableCell(withIdentifier: "CellsidemenuTableVc", for: indexPath) as! CellsidemenuTableVc
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
