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
    var didselectIndexSound = -1
    let image_greterthen = UIImage(systemName: "greaterthan")
//MARK: - Custem veriable
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_Side_Menu.delegate = self
        tbl_Side_Menu.dataSource = self
        Arry_menu_list = ["Appearance","Share App","Rate Us","Counter Sounds","Dynamic Touch"]
        arry_Disablelist = ["Neon","","","Default Click","Enabled"]
        image = ["square.split.bottomrightquarter.fill","scale.3d","hand.thumbsup.fill","music.note","dot.circle.and.hand.point.up.left.fill"]
        barButtonItem()
       
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SoundViewController" {
            _ = segue.destination as? SoundViewController
        }
    }
    //MARK: - All Custum method
    func barButtonItem(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(GoBackVcRoot))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.2.fill"), style: .plain, target: self, action: #selector(GoRootFirst))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        backButton.tintColor = .white
        title = "Menu"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

    }
    
    @objc func GoBackVcRoot(){
        
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func GoRootFirst(){
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}
//MARK: - UITableViewDelegate, && UITableViewDataSource
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Arry_menu_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbl_Side_Menu.dequeueReusableCell(withIdentifier: "CellsidemenuTableVc", for: indexPath) as! CellsidemenuTableVc
//        var imageView = UIImageView(image: image_greterthen!)
//       // imageView = UIImageView(frame: CGRectMake(304, , 25, 25))
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .white
//        cell.cell_view_contentview.addSubview(imageView)
//       // imageView.center = CGPointMake(,cell.cell_view_contentview.bounds.size.height/2);
        cell.switch_true_false_dynamicTuch.isHidden = true
        cell.img_arrrow_next.isHidden = true
        cell.lbl_notification.text = Arry_menu_list[indexPath.row]
        cell.lbl_Enable_disable.text = arry_Disablelist[indexPath.row]
        cell.img_Star_rate.image = UIImage(systemName: image[indexPath.row])
        if indexPath.row == 4{
            cell.switch_true_false_dynamicTuch.isHidden = false
            //imageView.removeFromSuperview()
        }else{
            cell.img_arrrow_next.isHidden = false
           // cell.cell_view_contentview.addSubview(imageView)
           
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tbl_Side_Menu.dequeueReusableCell(withIdentifier: "CellsidemenuTableVc") as! CellsidemenuTableVc
        if indexPath.row == 0{
            
        }else  if indexPath.row == 1{
            shareapp()
        }else  if indexPath.row == 2{
            rateApp()
        }else if indexPath.row == 3{
            performSegue(withIdentifier: "SoundViewController", sender: self)
        }
      
    }
    func playVideoButtonDidSelect() {
        let nav = SoundViewController()
        let navigationControlr = UINavigationController(rootViewController: nav)
        navigationControlr.modalPresentationStyle = .fullScreen
        self.present(navigationControlr, animated: true, completion: nil)
       }

    
    func rateApp() {
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            guard let url = URL(string: Open_rate_url), UIApplication.shared.canOpenURL(url) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url) // openURL(_:) is deprecated from iOS 10.
            }
        }
    }
    
    func shareapp(){
        if !Open_share_url!.absoluteString.isEmpty {
            let objectsToShare = [Open_share_url]
            let activityVC = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        } else {
            // show alert for not available
        }
    }
    
    
}
