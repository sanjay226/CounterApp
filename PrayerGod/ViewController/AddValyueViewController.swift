//
//  AddValyueViewController.swift
//  PrayerGod
//
//  Created by macOS on 17/04/23.
//

import UIKit
protocol AddValyuViewControllerDelegate{
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
    
    var delegate_addVc : AddValyuViewControllerDelegate?
    var select_Index_list_Vc_database = Int()
    var is_selectIndex_bool_Dtabase = Bool()
    //MARK: - Application lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        allmetodeAssignViewDidload()
       
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
    }
    
    func selected_index_list_on_listVc(){
        if is_selectIndex_bool_Dtabase{
            var newdatabaseindex_data = databasehelper.sharaintance.getdata()
            let data = newdatabaseindex_data[select_Index_list_Vc_database]
            txt_reminder.text=String(data.reminder)
            txt_title.text = data.title
            txt_Start_value.text = String(data.startValue)
            txt_target_value.text = String(data.targetValue)
            textView_Note.text = data.note
        
         }
    }

    func updateName_Value_all_list(){
        var newdatabaseindex_data = databasehelper.sharaintance.getdata()
        newdatabaseindex_data[select_Index_list_Vc_database].title = txt_title.text ?? ""
        newdatabaseindex_data[select_Index_list_Vc_database].reminder = Int16(txt_reminder.text ?? "") ?? 0
        newdatabaseindex_data[select_Index_list_Vc_database].startValue = Int16(txt_Start_value.text ?? "") ?? 0
        newdatabaseindex_data[select_Index_list_Vc_database].targetValue = Int16(txt_target_value.text ?? "") ?? 0
        newdatabaseindex_data[select_Index_list_Vc_database].note = textView_Note.text ?? ""
       
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
    
    
    @objc func GoFirst_view_controller(){
       // txt_target_all_textfield(txt_reminder)
        
//        if txt_title.text != "" || txt_Start_value.text != "" || txt_target_value.text != "" || txt_reminder.text != "" {
//
//                if Start_convert_int >= End_convert_int{
//                    height_targetvalue.constant = 20
//                    View_Height_Tragetvalue.constant = 116
//                    lbl_target_six_digit_value.text = "not enter greter"
//                }else{
//                    height_targetvalue.constant = 0
//                    View_Height_Tragetvalue.constant = 88
//                }
////            if End_convert_int <= Start_convert_int{
////                height_value.constant = 20
////                View_Height_Value.constant = 116
////               lbl_strat_Value_six_digit.text = "not enter greter"
////            }else{
////                height_value.constant = 0
////                View_Height_Value.constant = 88
////               }
//
//
//           }
       // text_fields_validation(txt_reminder, height_reminder, View_Height_reminder, lbl_reminders_six_digit)
        if is_selectIndex_bool_Dtabase{
            if self.presentingViewController != nil{
                
                self.dismiss(animated: true, completion: nil)
                
            }else{
                self.navigationController?.popViewController(animated: true)
                
            }
           updateName_Value_all_list()
            databasehelper.sharaintance.saveItems()
            
        }else{
            savedata()
            self.presentingViewController?.dismiss(animated: false, completion: nil)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate_addVc?.popupCloseEvent()
            GlobalData.sharedInstance.isFromSaveTask = true
            GlobalData.sharedInstance.selectindex = databasehelper.sharaintance.getdata().last
        }
        
    }
func text_fields_validation( _ textfield : UITextField, _ height : NSLayoutConstraint,_ viewheight : NSLayoutConstraint,_ lbl : UILabel){
        if textfield.text!.count > 6 {
            height.constant = 20
            viewheight.constant = 116
            lbl.backgroundColor = .white
        }else{
            height.constant = 0
            viewheight.constant = 88
        }
 
    }
func counting_Range_value_txt(){
    
  }
    func lbl_height_zero(_ sender : NSLayoutConstraint ,_ txtfield : UITextField){
    sender.constant = 0
    }
    
    func view_height_constrain_zero(_ sender: NSLayoutConstraint,_ txtfield : UITextField){
        sender.constant = 88
    }
    
    func savedata(){
        let objTask = TaskModel(title: txt_title.text, startValue: Int(txt_Start_value.text ?? ""),reminder: Int(txt_reminder.text ?? ""), targetValue: Int(txt_target_value.text ?? ""), note: textView_Note.text, date: Date())
        databasehelper.sharaintance.dataSave(object: objTask)
        databasehelper.sharaintance.saveItems()
        
        
    }
    
}
private var kAssociationKeyMaxLength: Int = 0
extension UITextField {

    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self,&kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }

    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }

        let selection = selectedTextRange

        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)

        selectedTextRange = selection
    }
}
extension AddValyueViewController : UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
//    func textFieldDidBeginEditing(textField: UITextField) -> Bool {
//        if textField == txt_title {
//            if textField.text != "" && textField.text!.count > 3{
//                lbl_six_digitEnter.text = "ijsdfouq"
//                height_title.constant = 20
//                View_Height_title.constant = 116
//            }else{
//                height_title.constant = 0
//                View_Height_title.constant = 88
//            }
//
//        }
//        return true
//    }

       

    }

