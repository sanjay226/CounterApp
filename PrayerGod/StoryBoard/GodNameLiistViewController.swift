//
//  GodNameLiistViewController.swift
//  PrayerGod
//
//  Created by macOS on 07/05/35.
//

//import UIKit
//
//class GodNameLiistViewController: UIViewController{
//
//    @IBOutlet weak var tbl_god_name_list: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tbl_god_name_list.delegate = self
//        tbl_god_name_list.dataSource = self
//       
//    }
//}
////MARK: - UITableViewDelegate, && UITableViewDataSource
//extension GodNameLiistViewController : UITableViewDelegate,UITableViewDataSource{
// 
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return 55
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    
//        let cell = tbl_god_name_list.dequeueReusableCell(withIdentifier: "CellGodNameList", for: indexPath) as! CellGodNameList
//         return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//}
