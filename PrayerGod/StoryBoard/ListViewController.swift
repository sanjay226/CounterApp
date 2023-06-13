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
    @IBOutlet weak var btn_sort_Value: UIButton!
    @IBOutlet weak var btn_view_cansal: UIButton!
    @IBOutlet weak var btn_continue: UIButton!
    @IBOutlet weak var lbl_sort_continue: UILabel!
    @IBOutlet weak var lbl_Alphabetic_sort_value: UILabel!
    @IBOutlet weak var lbl_cancel: UILabel!
    @IBOutlet weak var lbl_sort_value: UILabel!
    @IBOutlet weak var lbl_sort_Date: UILabel!
    @IBOutlet weak var View_Sorted_All_data_bottomview: UIView!
    @IBOutlet weak var viewGesture_cover_bottom_sheet: UIView!
    @IBOutlet weak var img_continue_bottom_view: UIImageView!
    @IBOutlet weak var img_sourt_bydate_bottomview: UIImageView!
    @IBOutlet weak var view_continue_bottomview: UIView!
    @IBOutlet weak var img_Alphabetic_sort_bottomview: UIImageView!
    @IBOutlet weak var img_cansal_bottomview: UIImageView!
    @IBOutlet weak var img_sort_by_value_bottomview: UIImageView!
    //MARK: - All veriable
    var Ary_textfield_get_list = [Garland]()
    var progressTarget = Float()
    var didselectIndex = -1
    lazy var is_Sort_all_ButtonClicked = Bool()
    lazy var is_btn_bottomview_dilitrow = Bool()
    lazy var is_btn_bottomview_Edit = Bool()
    lazy var ispresen_tbottom_view = true
    lazy var isnavigation_blank_or_fill = Bool()
    var view_nodata_lable_table = UIView()
//MARK: - Application lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Tbl_list_of_malaEnding.delegate = self
        Tbl_list_of_malaEnding.dataSource = self
        set_lefr_and_right_barButtonItem()
        Ary_textfield_get_list = databasehelper.sharaintance.getdata()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
       viewGesture_cover_bottom_sheet.addGestureRecognizer(tapGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewGesture_cover_bottom_sheet.isHidden = true
        DispatchQueue.main.async { [self] in
            Tbl_list_of_malaEnding.reloadData()
        }
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
        
        viewGesture_cover_bottom_sheet.isHidden = false
        lbl_Alphabetic_sort_value.text = "Alphabetic Sort"
        lbl_sort_Date.text = "Sort By Date"
        lbl_sort_value.text = "Sort by Value"
        view_continue_bottomview.isHidden = true
        is_Sort_all_ButtonClicked = true
        btn_open_addlistVc.isHidden = true
        
        View_Sorted_All_data_bottomview.isHidden = false
        View_Sorted_All_data_bottomview.isUserInteractionEnabled = true
        Tbl_list_of_malaEnding.isUserInteractionEnabled = false
        ispresen_tbottom_view.toggle()
          }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        viewGesture_cover_bottom_sheet.isHidden = true
        showwAndHideFilterMenu(category: 1)
        View_Sorted_All_data_bottomview.isHidden = true
        Tbl_list_of_malaEnding.isUserInteractionEnabled = true
        ispresen_tbottom_view.toggle()
        hide_mainbottom_view()
        is_Sort_all_ButtonClicked = Bool()
     }
    
    func getActiveTAskIndex_in_list() -> Int{
        let taskList = databasehelper.sharaintance.getdata()
        if let index = taskList.firstIndex(where: {$0.isActive == true}){
            return index
        }else{
            return -1
        }
    }
  //gesture bottonview hide
    func hide_mainbottom_view(){
        viewGesture_cover_bottom_sheet.isHidden = true
        btn_open_addlistVc.isHidden = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    //gesture bottonview show
    func show_mainbottom_view(){
        viewGesture_cover_bottom_sheet.isHidden = false
        btn_open_addlistVc.isHidden = true
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func bottom_up()  {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.View_Sorted_All_data_bottomview.frame = CGRect(x: 0, y: 0, width: 393, height: 20)
        }) { [self] (finished) in
            if finished {
                viewGesture_cover_bottom_sheet.isHidden = true
            }
        }
    }
    
    func showwAndHideFilterMenu(category : Int) {
        if ispresen_tbottom_view == true{
            bottom_up()
            ispresen_tbottom_view.toggle()
        }else{
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: { [self] in
            self.View_Sorted_All_data_bottomview.isHidden = true
            ispresen_tbottom_view.toggle()
        }) { [self] (finished) in
            if finished {
               hide_mainbottom_view()
                }
            }
        }
    }
    
    func shortedAlphabetic(){
        let sortedarry = Ary_textfield_get_list.sorted() { $0.title!.lowercased() < $1.title!.lowercased() }
            Ary_textfield_get_list = sortedarry
            tblview_reload()
    }
    
    func tblview_reload(){
        DispatchQueue.main.async {
            self.Tbl_list_of_malaEnding.reloadData()
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
          
        }) { [self] (finished) in
            if finished {
               hide_mainbottom_view()
               }
            }
        Tbl_list_of_malaEnding.isUserInteractionEnabled = true
        is_Sort_all_ButtonClicked = Bool()
        self.navigationItem.rightBarButtonItem?.isEnabled = true
       }

@IBAction func btnPopupEvents(_ sender: UIButton){
    if is_Sort_all_ButtonClicked{
        switch sender.tag {
            case 1:
                shortedAlphabetic()
                View_Sorted_All_data_bottomview.isHidden = true
                Tbl_list_of_malaEnding.isUserInteractionEnabled = true
                ispresen_tbottom_view.toggle()
                hide_mainbottom_view()
                is_Sort_all_ButtonClicked = Bool()
            case 2:
              let sorted = Ary_textfield_get_list.sorted(by: { ($0.date ?? Date()) > ($1.date ?? Date())})
                Ary_textfield_get_list = sorted
                tblview_reload()
                View_Sorted_All_data_bottomview.isHidden = true
                Tbl_list_of_malaEnding.isUserInteractionEnabled = true
                ispresen_tbottom_view.toggle()
                hide_mainbottom_view()
                is_Sort_all_ButtonClicked = Bool()
            case 3:
                let sorted = Ary_textfield_get_list.sorted(by: { ($0.startValue ) > ($1.startValue)})
                Ary_textfield_get_list = sorted
                tblview_reload()
                View_Sorted_All_data_bottomview.isHidden = true
                is_Sort_all_ButtonClicked = Bool()
                Tbl_list_of_malaEnding.isUserInteractionEnabled = true
                ispresen_tbottom_view.toggle()
                hide_mainbottom_view()
                default:
                return
            }
        }else{
            ispresen_tbottom_view.toggle()
            switch sender.tag {
            case 1:
                let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddValyueViewController") as! AddValyueViewController
                
                let navigationController = UINavigationController(rootViewController: nav)
                navigationController.setNavigationBarHidden(false, animated: true)
                let navigationControlr1 = UINavigationController(rootViewController: nav)
                navigationControlr1.modalPresentationStyle = .fullScreen
                nav.delegate_addVc = self
                nav.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                nav.navigationController?.modalPresentationStyle = .fullScreen
                nav.select_Index_list_Vc_database = didselectIndex
                nav.is_selectIndex_bool_Dtabase_Edit = true
                GlobalData.sharedInstance.isFromSaveTask = true
                present(navigationControlr1, animated: true)
                View_Sorted_All_data_bottomview.isHidden = true
                is_Sort_all_ButtonClicked = Bool()
                hide_mainbottom_view()
            case 2:
                Ary_textfield_get_list[didselectIndex].startValue = 0
                databasehelper.sharaintance.saveItems()
                Ary_textfield_get_list = databasehelper.sharaintance.getdata()
                tblview_reload()
                View_Sorted_All_data_bottomview.isHidden = true
                is_Sort_all_ButtonClicked = Bool()
                hide_mainbottom_view()
            case 3:
               let data_list = databasehelper.sharaintance.getdata()
                let index = data_list.firstIndex(where: {$0.isActive == true})
                if index == didselectIndex
                {
                    let alertController = UIAlertController(title: "Delete Failed", message: "This data couldn't be deleted because it is active.", preferredStyle: UIAlertController.Style.alert)
                    alertController.setValue(NSAttributedString(string: "Delete Failed", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
                    alertController.setValue(NSAttributedString(string: "This data couldn't be deleted because it is active.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
                    let backView = alertController.view.subviews.last?.subviews.last
                    backView?.layer.cornerRadius = 5
                    alertController.view.layer.cornerRadius = 5
                    backView?.backgroundColor = .systemBrown
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                        View_Sorted_All_data_bottomview.isHidden = true
                        is_Sort_all_ButtonClicked = Bool()
                        hide_mainbottom_view()
                    }))
                    present(alertController, animated: true, completion: nil)
                }else{
                    Ary_textfield_get_list = databasehelper.sharaintance.allDelit(didselectIndex, objUser: Ary_textfield_get_list[didselectIndex])
                    Ary_textfield_get_list = databasehelper.sharaintance.getdata()
                    tblview_reload()
                    View_Sorted_All_data_bottomview.isHidden = true
                    is_Sort_all_ButtonClicked = Bool()
                    hide_mainbottom_view()
                }
            case 4:
             let taskList = databasehelper.sharaintance.getdata()
                if let index = taskList.firstIndex(where: {$0.isActive == true}){
                            taskList[index].isActive = false
                    taskList[didselectIndex].isActive = true
                }else{
                    taskList[didselectIndex].isActive = true
                }
                View_Sorted_All_data_bottomview.isHidden = true
                is_Sort_all_ButtonClicked = Bool()
                hide_mainbottom_view()
                GlobalData.sharedInstance.isFromSaveTask = true
                databasehelper.sharaintance.saveItems()
                if self.presentingViewController != nil{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
            default:
                return
            }
        }
    }
}

//MARK: - UITableViewDelegate &  UITableViewDataSource Methode
extension ListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(Ary_textfield_get_list.count == 0 ){
            Tbl_list_of_malaEnding.setEmptyMessage("No data found")
        } else{
            Tbl_list_of_malaEnding.restore()
            view_nodata_lable_table.isHidden = true
        }
       return Ary_textfield_get_list.count
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view_continue_bottomview.isHidden = false
        is_Sort_all_ButtonClicked = false
        show_mainbottom_view()
        View_Sorted_All_data_bottomview.isHidden = false
        View_Sorted_All_data_bottomview.isUserInteractionEnabled = true
        didselectIndex = indexPath.row
        lbl_sort_Date.text =  "Reset Counter"
        lbl_Alphabetic_sort_value.text = "Edit"
        lbl_sort_value.text = "Delete"
        img_sourt_bydate_bottomview.image = UIImage(systemName: "calendar.badge.plus")
        img_Alphabetic_sort_bottomview.image = UIImage(systemName: "repeat")
        img_sort_by_value_bottomview.image = UIImage(systemName: "10.square")
        self.navigationItem.rightBarButtonItem?.isEnabled = false
      //  GlobalData.sharedInstance.isFromSaveTask = true
    }
    
    func getCreatDate(obj: Garland) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssz"
        let date = dateFormatter.date(from: "\(obj.date ?? Date())")
        dateFormatter.dateFormat = "dd MMM, yyyy hh:mm a"
        return dateFormatter.string(from: date ?? Date())
    }
}

extension ListViewController: AddValueViewControllerDelegate{
    func popupCloseEvent() {
            Ary_textfield_get_list = databasehelper.sharaintance.getdata()
                DispatchQueue.main.async {
                        self.Tbl_list_of_malaEnding.reloadData()
                }
            }
        }

extension UITableView {
func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
