//
//  ListViewController.swift
//  PrayerGod
//
//  Created by macOS on 05/05/23.
//

import UIKit

class ListViewController: UIViewController{
  
    
    //MARK: -   @IBOutlet
    @IBOutlet weak var img_Add_dismis: UIImageView!
    @IBOutlet weak var Tbl_list_of_malaEnding: UITableView!
    @IBOutlet weak var btn_open_addlistVc: UIButton!
    @IBOutlet weak var btn_sort_alphabett: UIButton!
    @IBOutlet weak var btn_sort_Date: UIButton!
    @IBOutlet weak var btn_sort_Valyue: UIButton!
    @IBOutlet weak var btn_view_cansal: UIButton!
    @IBOutlet weak var lbl_Alphabetic_sort_valyue: UILabel!
    @IBOutlet weak var lbl_cancel: UILabel!
    @IBOutlet weak var lbl_sort_valyue: UILabel!
    @IBOutlet weak var lbl_sort_Date: UILabel!
    @IBOutlet weak var View_Sorted_All_data_bottomview: UIView!
   //MARK: - All veriable
    var showFilterMenu = true
    var Ary_textfield_get_list = [Garland]()
    var progressTarget = Float()
   //MARK: - Application lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Tbl_list_of_malaEnding.delegate = self
        Tbl_list_of_malaEnding.dataSource = self
        set_lefr_and_right_barButtonItem()
      
        Ary_textfield_get_list = databasehelper.sharaintance.getdata()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    //MARK: - Custem methode
    func set_lefr_and_right_barButtonItem(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(GoBackVc))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.indent"), style: .plain, target: self, action: #selector(show_Arrow_view))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        backButton.tintColor = .white
        title = "List"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        View_Sorted_All_data_bottomview.isHidden = true
        View_Sorted_All_data_bottomview.isUserInteractionEnabled = false
        
       
    }
    
    @objc func GoBackVc(){
    
        if self.presentingViewController != nil{
           
            self.dismiss(animated: true, completion: nil)
        }else{
          
            self.navigationController?.popViewController(animated: true)
            
            }
    }
    
    @objc func show_Arrow_view(){
        btn_open_addlistVc.isHidden = true
        
        View_Sorted_All_data_bottomview.isHidden = false
            View_Sorted_All_data_bottomview.isUserInteractionEnabled = true
       showwAndHideFilterMenu(category: 1)
    }
    
    func bottom_up()  {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.View_Sorted_All_data_bottomview.frame = CGRect(x: 0, y: 0, width: 393, height: 20)
        }) { (finished) in
            if finished {
                print("finished")
            }
        }
    }
func showwAndHideFilterMenu(category : Int) {
    if showFilterMenu == true{
        bottom_up()
        showFilterMenu = false
    }else{

        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: { [self] in
            self.View_Sorted_All_data_bottomview.isHidden = true
            showFilterMenu = true
        }) { [self] (finished) in
            if finished {
                btn_open_addlistVc.isHidden = false
            }
        }
 
    }
}

@IBAction func btn_did_tapped_open_addVc(_ sender: UIButton) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddValyueViewController") as! AddValyueViewController

        let navigationControlr1 = UINavigationController(rootViewController: nav)
        navigationControlr1.modalPresentationStyle = .fullScreen
        nav.delegate_addVc = self
    
        self.present(navigationControlr1, animated: true, completion: nil)
}
    
    @IBAction func btn_cencal_didtapped_go_rootVc(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: { [self] in
            self.View_Sorted_All_data_bottomview.isHidden = true
            showFilterMenu = true
        }) { [self] (finished) in
            if finished {
                btn_open_addlistVc.isHidden = false
               }
            
            }
       }
    @IBAction func btn_didtapped_short_valyue(_ sender: UIButton) {
       
    
    }
    
    @IBAction func btn_sort_Alphabet(_ sender: UIButton) {
      shortedAlphabetic()
    }
    
    func shortedAlphabetic(){
    
        let sortedarry = Ary_textfield_get_list.sorted() { $0.title!.lowercased() < $1.title!.lowercased() }
        Ary_textfield_get_list = sortedarry
       Tbl_list_of_malaEnding.reloadData()
        databasehelper.sharaintance.saveItems()
       
    }
    
    
    @IBAction func btn_sort_Date(_ sender: UIButton) {
//        let sorted = Ary_textfield_get_list.sorted(by: { ($0.garlandTime as? Date ?? Date.distantFuture) < ($1.garlandTime as? Date ?? Date.distantPast)})
//        Ary_textfield_get_list = sortedarry
//          Tbl_list_of_malaEnding.reloadData()
//          databasehelper.sharaintance.saveItems()
        
    }
    
    
}
//MARK: - UITableViewDelegate &  UITableViewDataSource Methode
extension ListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Ary_textfield_get_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellShowCurrentList", for: indexPath) as! CellShowCurrentList
        let obj = Ary_textfield_get_list[indexPath.row]
        
        let persent = (Float(obj.startValue) * 100) / Float(obj.targetValue)
        
        let formatted = String(format: "%.1f", persent)
        cell.progressView.setProgress(Float(obj.startValue)/Float(obj.targetValue), animated: true)
        cell.lbl_Days_ago.text = getCreatDate(obj: obj)
        cell.lbl_prabhuji_name.text = obj.title
        cell.lbl_mala_Count.text = String(obj.startValue)
        cell.lbl_persenteg.text = "\(formatted)%"
       return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func getCreatDate(obj: Garland) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssz"
        let date = dateFormatter.date(from: "\(obj.date ?? Date())")
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
    
}
extension ListViewController: AddValyuViewControllerDelegate{
   
    func popupCloseEvent() {
        Ary_textfield_get_list = databasehelper.sharaintance.getdata()
      
       DispatchQueue.main.async {
            self.Tbl_list_of_malaEnding.reloadData()
        }
    }
}

