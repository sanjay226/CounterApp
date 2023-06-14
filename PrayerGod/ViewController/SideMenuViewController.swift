//
//  SideMenuViewController.swift
//  PrayerGod
//
//  Created by macOS on 17/04/23.
//

import UIKit
import StoreKit

class SideMenuViewController: UIViewController {
//MARK: - All  @IBOutlet
    @IBOutlet weak var view_Addremove: UIView!
    @IBOutlet weak var tbl_Side_Menu: UITableView!
    var Arry_menu_list = [String]()
    var arry_Disablelist  = [String]()
    var image = [String]()
    //MARK: - Custem veriable
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_Side_Menu.delegate = self
        tbl_Side_Menu.dataSource = self
        Arry_menu_list = ["Appearance","Share App","Rate Us","Counter Sounds"]
        arry_Disablelist = ["Neon","","","Default Click"]
        image = ["Appearance","share","star","music"]
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
        cell.lbl_Enable_disable.text = arry_Disablelist[indexPath.row]
        cell.img_Star_rate.image = UIImage(named: image[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
        }else  if indexPath.row == 1{
            shareapp()
        }else  if indexPath.row == 2{
            rateApp()
        }else{
            
            
        }
    }
    func rateApp() {
        
        if #available(iOS 10.3, *) {
            
            SKStoreReviewController.requestReview()
            
        } else {
            let appID = "Your App ID on App Store"
            //   let urlStr = "https://itunes.apple.com/app/id\(appID)" // (Option 1) Open App Page
            let urlStr = "https://itunes.apple.com/app/id\(appID)?action=write-review" // (Option 2) Open App Review Page
            
            guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url) // openURL(_:) is deprecated from iOS 10.
            }
        }
    }
    
    func shareapp(){
        if let name = URL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8"), !name.absoluteString.isEmpty {
            let objectsToShare = [name]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        } else {
            // show alert for not available
        }
    }
}
