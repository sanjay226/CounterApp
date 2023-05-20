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

class AddValyueViewController: UIViewController, UITextFieldDelegate{
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
    var celllable_heightbool = Bool()
    var delegate_addVc : AddValyuViewControllerDelegate?
    //var booli = Bool()
   
    //MARK: - Application lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        allmetodeAssignViewDidload()
       
    }
//MARK: - Custum Function
    func allmetodeAssignViewDidload(){
        set_lefr_and_right_barButtonItem_Add()
        lbl_height_zero(height_title, txt_title)
        lbl_height_zero(height_value,txt_Start_value)
        lbl_height_zero(height_reminder,txt_reminder)
        lbl_height_zero(height_targetvalue,txt_target_value)
        view_height_constrain_zero(View_Height_title,txt_title)
        view_height_constrain_zero(View_Height_Value,txt_Start_value)
        view_height_constrain_zero(View_Height_reminder,txt_reminder)
        view_height_constrain_zero(View_Height_Tragetvalue,txt_target_value)
        
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
      
      
        if txt_title.text != "" {
            savedata()
            self.presentingViewController?.dismiss(animated: false, completion: nil)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.delegate_addVc?.popupCloseEvent()
            GlobalData.sharedInstance.isFromSaveTask = true
         
        }
    }
   
    func lbl_height_zero(_ sender : NSLayoutConstraint ,_ txtfield : UITextField){
        if txtfield.text!.count > 5{
          // sender.constant = 15
        }else{
          //  sender.constant = 0
        }
    }
    
    func view_height_constrain_zero(_ sender: NSLayoutConstraint,_ txtfield : UITextField){
        if txtfield.text!.count > 6{
            sender.constant = 116
        }else{
            sender.constant = 88
        }
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
