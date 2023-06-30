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
//MARK:- Custum veriable
    var Arry_menu_list = [String]()
    var arry_Disablelist  = [String]()
    var image = [String]()
    var IsSwitchBool = false
    var didselectIndexSound = -1
    let image_greterthen = UIImage(systemName: "greaterthan")
 
//MARK: - Custem veriable
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_Side_Menu.delegate = self
        tbl_Side_Menu.dataSource = self
        Arry_menu_list = ["Appearance","Share App","Rate Us","Counter Sounds","Dynamic Touch"]
        arry_Disablelist = ["Neon","","","Default Click",""]
        image = ["square.split.bottomrightquarter.fill","scale.3d","hand.thumbsup.fill","music.note","dot.circle.and.hand.point.up.left.fill"]
        barButtonItem()
        
            IsSwitchBool = UserDefaults.standard.bool(forKey: "mySwitch")
        
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SoundViewController" {
            _ = segue.destination as? SoundViewController
        }else if segue.identifier == "AppearanceViewController"{
            _ = segue.destination as? AppearanceViewController
        }
    }
    //MARK: - All Custum method
    func barButtonItem(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(GoBackVcRoot))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.2.fill"), style: .plain, target: self, action: #selector(CountingTappGescher_Go_root_save))
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
    
    @objc func CountingTappGescher_Go_root_save(){
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
      // UserDefaults.standard.set(save_SaveswitchData_Disabled_in_UserDefaultst, forKey: "mySwitch")
    }
}
//MARK: - UITableViewDelegate, && UITableViewDataSource
extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Arry_menu_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl_Side_Menu.dequeueReusableCell(withIdentifier: "CellsidemenuTableVc", for: indexPath) as! CellsidemenuTableVc
        cell.Indicatore_when_NotOpenApp.isHidden = true
        cell.switch_true_false_dynamicTuch.isHidden = true
        cell.img_arrrow_next.isHidden = true
        cell.lbl_notification.text = Arry_menu_list[indexPath.row]
        cell.lbl_Enable_disable.text = arry_Disablelist[indexPath.row]
        cell.img_Star_rate.image = UIImage(systemName: image[indexPath.row])
       
        if indexPath.row == 4{
            cell.switch_true_false_dynamicTuch.isHidden = false
            cell.switch_true_false_dynamicTuch.isUserInteractionEnabled = false
            
            let status = UserDefaults.standard.bool(forKey: "mySwitch")
            cell.switch_true_false_dynamicTuch.isOn = status
            cell.lbl_Enable_disable.text = status ? "Enabled" : "Disabled"
        }else{
            cell.img_arrrow_next.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CellsidemenuTableVc
     
        if indexPath.row == 0{
            performSegue(withIdentifier: "AppearanceViewController", sender: self)
        }else  if indexPath.row == 1{
            shareapp()
        }else  if indexPath.row == 2{
            cell?.Indicatore_when_NotOpenApp.isHidden = false
            ActivityIndicatorView()
            rateApp()
           dismiss(animated: false, completion: nil)
        }else if indexPath.row == 3{
            performSegue(withIdentifier: "SoundViewController", sender: self)
        }else if indexPath.row == 4{
            IsSwitchBool = !IsSwitchBool
            print(IsSwitchBool,"isSwitch")
            if IsSwitchBool{
                cell?.switch_true_false_dynamicTuch.isOn = true
                cell?.lbl_Enable_disable.text = "Enabled"
            }else{
                cell?.switch_true_false_dynamicTuch.isOn = false
                cell?.lbl_Enable_disable.text = "Disabled"
                }
            if cell?.switch_true_false_dynamicTuch.isOn  == true{
                UserDefaults.standard.set(true, forKey: "mySwitch")
            } else {
                   
                UserDefaults.standard.set(false, forKey: "mySwitch")
            }
            UserDefaults.standard.synchronize()
        }
    }
    
    func ActivityIndicatorView(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
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
        if !Open_share_url.isEmpty {
     let objectsToShare = [Open_share_url]
           let activityVC = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        } else {
            // show alert for not available
        }
    }
    
    
}
