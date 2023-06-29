//
//  AddValyueViewController.swift
//  PrayerGod
//
//  Created by macOS on 17/04/23.
//

import UIKit
protocol AddValueViewControllerDelegate{
    func popupCloseEvent()
}

class AddValyueViewController: UIViewController{
    //MARK: - All @IBOutlet
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var txt_title: UITextField!
    @IBOutlet weak var lbl_six_digitEnter: UILabel!
    @IBOutlet weak var txt_Start_value: UITextField!
    @IBOutlet weak var lbl_Start_Value: UILabel!
    @IBOutlet weak var lbl_strat_Value_six_digit: UILabel!
    @IBOutlet weak var lbl_reminder: UILabel!
    @IBOutlet weak var txt_reminder: UITextField!
    @IBOutlet weak var lbl_reminders_six_digit: UILabel!
    @IBOutlet weak var lbl_target_Vllue: UILabel!
    @IBOutlet weak var txt_target_value: UITextField!
    @IBOutlet weak var view_main_title: UIView!
    @IBOutlet weak var view_main_StartValue: UIView!
    @IBOutlet weak var view_main_Reminder: UIView!
    @IBOutlet weak var view_main_targetVlue: UIView!
    @IBOutlet weak var lbl_target_six_digit_value: UILabel!
    @IBOutlet weak var lbl_note: UILabel!
    @IBOutlet weak var textView_Note: UITextView!
    @IBOutlet weak var height_title: NSLayoutConstraint!
    @IBOutlet weak var height_value: NSLayoutConstraint!
    @IBOutlet weak var height_reminder: NSLayoutConstraint!
    @IBOutlet weak var height_targetvalue: NSLayoutConstraint!
    @IBOutlet weak var View_Height_title: NSLayoutConstraint!
    @IBOutlet weak var View_Height_Value: NSLayoutConstraint!
    @IBOutlet weak var View_Height_reminder
    : NSLayoutConstraint!
    @IBOutlet weak var View_Height_Tragetvalue: NSLayoutConstraint!
    //MARK: - All veriable
    var delegate_addVc : AddValueViewControllerDelegate?
    var select_Index_list_Vc_database = Int()
    var selectdate_list_Vc = Date()
    var is_selectIndex_bool_Dtabase_Edit = Bool()
    var isEdit_first_vc_topviewData = Bool()
    var firstVc_ccurent_list_show_start_value = "0"
    //MARK: - Application lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        allmetodeAssignViewDidload()
      txt_Start_value.text = firstVc_ccurent_list_show_start_value
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selected_index_list_on_listVc()
        
}
    //MARK: - Custum Function
    func allmetodeAssignViewDidload(){
        height_reminder.constant = 0
        height_title.constant = 0
        height_value.constant = 0
        height_targetvalue.constant = 0
        View_Height_reminder.constant = 88
        View_Height_Value.constant = 88
        View_Height_Tragetvalue.constant = 88
        View_Height_title.constant = 88
        set_lefr_and_right_barButtonItem_Add()
        txt_target_value.delegate = self
        txt_title.delegate = self
        txt_reminder.delegate = self
        txt_Start_value.delegate = self
    }
    
    func selected_index_list_on_listVc(){
        if is_selectIndex_bool_Dtabase_Edit{
            let newdatabaseindex_data = databasehelper.sharaintance.getdata()
            if let index = newdatabaseindex_data.firstIndex(where: {$0.date == selectdate_list_Vc}){
                let data = newdatabaseindex_data[index]
                print(data.reminder)
                txt_reminder.text=String(data.reminder)
                txt_title.text = data.title
                txt_Start_value.text = String(data.startValue)
                txt_target_value.text = String(data.targetValue)
                textView_Note.text = data.note
            }
        }else if isEdit_first_vc_topviewData{
            let editGarland_firstVc_topview = databasehelper.sharaintance.getdata()
            let newdata_first_vc = editGarland_firstVc_topview[select_Index_list_Vc_database]
            txt_title.text = newdata_first_vc.title
            txt_target_value.text = String(newdata_first_vc.targetValue)
            txt_reminder.text = String(newdata_first_vc.reminder)
            txt_Start_value.text = String(newdata_first_vc.startValue)
            textView_Note.text = newdata_first_vc.note
        }
    }
    
    func updateName_Value_all_list(){
        let newdatabaseindex_data = databasehelper.sharaintance.getdata()
        if let index = newdatabaseindex_data.firstIndex(where: {$0.date == selectdate_list_Vc}){
            newdatabaseindex_data[index].title = txt_title.text ?? ""
            newdatabaseindex_data[index].reminder = Int32(txt_reminder.text ?? "") ?? 0
            newdatabaseindex_data[index].startValue = Int32(txt_Start_value.text ?? "") ?? 0
            newdatabaseindex_data[index].targetValue = Int32(txt_target_value.text ?? "") ?? 0
            newdatabaseindex_data[index].note = textView_Note.text ?? ""
            newdatabaseindex_data[index].date = Date()
        }
    }
    
    func set_lefr_and_right_barButtonItem_Add(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(GoRootVc))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .plain, target: self, action: #selector(GoFirst_view_controller))
        self.navigationItem.rightBarButtonItem?.tintColor = .green
        let backButton1 = UIBarButtonItem()
        backButton1.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton1
        backButton1.tintColor = .white
        title = "Add New"
        let textAttributes1 = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes1
    }
    
    @objc func GoRootVc(){
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func Go_rootView_Whiele_DataSave(){
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func GoFirst_view_controller(){
        if txt_title.text == ""{
            lbl_six_digitEnter.text = "This field is required."
            View_Height_title.constant = 110
            height_title.constant = 20
        }else if txt_Start_value.text == "" && txt_reminder.text == "" && txt_target_value.text == ""{
            saveDataAndSetValueIfBlank()
        }else if Int(txt_Start_value.text ?? "") ?? 0  >= Int( txt_target_value.text ?? "") ?? 0 {
            lbl_target_six_digit_value.text = "Must be greater than the start value."
            View_Height_Tragetvalue.constant = 110
            height_targetvalue.constant = 20
        }else if Int(txt_target_value.text ?? "") ?? 0  <= Int( txt_reminder.text ?? "") ?? 0{
            lbl_reminders_six_digit.text = "Must be less than the target value."
            height_reminder.constant = 20
            View_Height_reminder.constant = 110
        }else if Int(txt_target_value.text ?? "") ?? 0 <= Int(txt_reminder.text ?? "") ?? 0{
            lbl_reminders_six_digit.text = "Must be less than the target value."
            height_reminder.constant = 20
            View_Height_reminder.constant = 110
        }
        else if is_selectIndex_bool_Dtabase_Edit{
            Go_rootView_Whiele_DataSave()
            updateName_Value_all_list()
            databasehelper.sharaintance.saveItems()
        }else if isEdit_first_vc_topviewData{
            Go_rootView_Whiele_DataSave()
            let newdatabaseindex_data = databasehelper.sharaintance.getdata()
            let updatedata = newdatabaseindex_data[select_Index_list_Vc_database]
            updatedata.title = txt_title.text
            updatedata.targetValue = Int32(txt_target_value.text ?? "") ?? 0
            updatedata.startValue = Int32(txt_Start_value.text ?? "") ?? 0
            updatedata.reminder = Int32(txt_reminder.text ?? "") ?? 0
            updatedata.note = textView_Note.text ?? ""
            updatedata.date = Date()
            updatedata.isActive = true
            self.delegate_addVc?.popupCloseEvent()
            GlobalData.sharedInstance.isFromSaveTask = true
            databasehelper.sharaintance.saveItems()
        }
        else {
            saveDataAndSetValueIfBlank()
            Go_rootView_Whiele_DataSave()
        }
    }
    
    func saveDataAndSetValueIfBlank(){
        txt_Start_value.text = txt_Start_value.text == "" ? "0" : txt_Start_value.text
        txt_reminder.text = txt_reminder.text == "" ? "0" : txt_reminder.text
        txt_target_value.text = txt_target_value.text == "" ? "0" : txt_target_value.text
        savedata()
        self.delegate_addVc?.popupCloseEvent()
        GlobalData.sharedInstance.isFromSaveTask = true
        let data = databasehelper.sharaintance.getdata().last
        var new = databasehelper.sharaintance.getdata()
        let newdata = new.firstIndex(where: {$0 == data})
        var taskList = databasehelper.sharaintance.getdata()
        let index = taskList.firstIndex(where: {$0.isActive == true})
        taskList[index!] = taskList[newdata!]
    }
    
    func savedata(){
        updateListTask()
        let objTask = TaskModel(title: txt_title.text, startValue: Int(txt_Start_value.text ?? "") ?? 0,reminder: Int(txt_reminder.text ?? "") ?? 0, targetValue: Int(txt_target_value.text ?? "") ?? 0, note: textView_Note.text ?? "", date: Date(), isActive: true)
        databasehelper.sharaintance.dataSave(object: objTask)
        print(databasehelper.sharaintance.getdata())
    }
    
    func updateListTask(){
        let data = databasehelper.sharaintance.getdata()
        var jio: [()] = data.map({$0.isActive = false})
      }
}
//MARK:- UITextFieldDelegat
extension AddValyueViewController : UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count
        if (range.length + range.location > currentCharacterCount ?? 0 ){
            return false
        }
        let newLength = (currentCharacterCount ?? 0) + string.count - range.length
        if newLength >= 6 && textField.isEqual(txt_reminder){
            lbl_reminders_six_digit.text = "Maximum 6 digits."
            height_reminder.constant = 20
            View_Height_reminder.constant = 110
        }else if newLength >= 6 && textField.isEqual(txt_Start_value){
            lbl_strat_Value_six_digit.text = "Maximum 6 digits."
            height_value.constant = 20
            View_Height_Value.constant = 110
        }
        else if newLength >= 6 && textField.isEqual(txt_target_value){
            lbl_target_six_digit_value.text = "Maximum 6 digits."
            height_targetvalue.constant = 20
            View_Height_Tragetvalue.constant = 110
        }else if newLength >= 0 && textField.isEqual(txt_title) {
            height_title.constant = 0
            View_Height_title.constant = 88
        }else {
            height_reminder.constant = 0
            View_Height_reminder.constant = 88
            height_value.constant = 0
            View_Height_Value.constant = 88
            height_targetvalue.constant = 0
            View_Height_Tragetvalue.constant = 88
            height_title.constant = 0
            View_Height_title.constant = 88
        }
        return true
    }
}
       

    

