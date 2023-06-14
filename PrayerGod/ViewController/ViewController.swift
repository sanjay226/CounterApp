//
//  ViewController.swift
//  PrayerGod
//
//  Created by macOS on 16/04/23.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController{
    //MARK: -   @IBOutlet
    @IBOutlet weak var view_Main_Grediantcoloure: UIView!
    @IBOutlet weak var btn_pluse_count: UIButton!
    @IBOutlet weak var btn_minus_count: UIButton!
    @IBOutlet weak var btn_Reload_count: UIButton!
    @IBOutlet weak var lbl_Show_counting_Value: UILabel!
    @IBOutlet weak var view_reset_Counting_bottom_sheet: UIView!
    @IBOutlet weak var img_coloure_convertore: UIImageView!
    @IBOutlet weak var btn_change_view_coloure: UIButton!
    @IBOutlet weak var btn_list: UIButton!
    @IBOutlet weak var btn_Sound: UIButton!
    @IBOutlet weak var btn_vibration: UIButton!
    @IBOutlet weak var btn_change_Mode: UIButton!
    @IBOutlet weak var progressview: UIProgressView!
    @IBOutlet weak var lbl_title_topview: UILabel!
    @IBOutlet weak var lbl_reminder_topview: UILabel!
    @IBOutlet weak var lbl_target_topview: UILabel!
    @IBOutlet weak var btn_End_topview: UIButton!
    @IBOutlet weak var btn_Edit_topview: UIButton!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var view_reminder: UIView!
    @IBOutlet weak var view_End_Edit_btn: UIView!
    
    @IBOutlet weak var view_gesture_reaset_counter: UIView!
    @IBOutlet weak var btn_vnavigationItem_rightbar_BtnItem: UIButton!

    @IBOutlet weak var lbl_resetCounter_bottom_view: UILabel!
    
    @IBOutlet weak var lbl_AreYou_sure_boomview: UILabel!
    
    //MARK: - All veriable
    var arry_panding_Image = ["volume.1","video.square","list.bullet.rectangle","paintpalette.fill","homekit"]
    var counting = Int()
    var selectedsound = false
    var selectedvibration = false
    var selectedlist = false
    var selectedcoloure = false
    var selectedmode = false
    var resetBollian = true
    var vibrationbool = false
    var colourevibrationcount = false
    var audioPlayer = AVAudioPlayer()
    let music = Bundle.main.path(forResource: "sound", ofType: "mp3")
    let colors: [UIColor] = [
        .systemYellow,
        .systemGreen,
        .systemPurple,
        .systemPink,
        .systemRed,
        .systemBlue,
        .systemOrange,
        .gray]
    var bgColor = UIColor()
    var counterBgColor = UIColor()
    var counterBorderColor = UIColor()
    var current_data_list_obj = Garland()
    var strtvalueofprogresview = Float()
    var End_progresscount = Float()
    var is_bootom_EndMala = Bool()
    lazy var isnavigation_bar_coloure_change = Bool()
    lazy var isColore_top_btnNavigation = Bool()
    var vnavigationcolore = UIColor()
    var GlobalData_Save_Index = Int()
//MARK: - Application lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AllCutemMethoddeToSet_VIewLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handle_Tap_Gesture(sender:)))
       view_gesture_reaset_counter.addGestureRecognizer(tapGesture)
        view_gesture_reaset_counter.isHidden = true
        
        bgColor = self.colors.randomElement()!
        counterBgColor = self.colors.randomElement()!
        counterBorderColor = self.colors.randomElement()!
    }
    
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view_End_Edit_btn.isHidden = true
        var isFromSaveTask = GlobalData.sharedInstance.isFromSaveTask ?? false
        let newgetdata_of_database = databasehelper.sharaintance.getdata()
        let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true})
    if newgetdata_of_database.isEmpty || index == nil{
            stackview.isHidden = true
            GlobalData.sharedInstance.isFromSaveTask = false
    }else if  newgetdata_of_database[index!].isActive == true || !is_bootom_EndMala || isFromSaveTask{
        current_data_list_obj = newgetdata_of_database[index!]
        btn_vnavigationItem_rightbar_BtnItem.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn_vnavigationItem_rightbar_BtnItem.tintColor = .black
        stackview.isHidden = false
        stackview.backgroundColor = .clear
        isnavigation_bar_coloure_change = true
        btn_vnavigationItem_rightbar_BtnItem.backgroundColor = counterBorderColor
        lbl_title_topview.text = current_data_list_obj.title
        lbl_target_topview.text = "Target : \(current_data_list_obj.targetValue)"
        lbl_reminder_topview.text = "Reminder : \(current_data_list_obj.reminder)"
        strtvalueofprogresview = (Float(current_data_list_obj.startValue) / Float(current_data_list_obj.targetValue))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        progressview.setProgress(strtvalueofprogresview, animated: true)
        counting = Int(current_data_list_obj.startValue)
        lbl_Show_counting_Value.text = "\(counting)"
        view_reset_Counting_bottom_sheet.isHidden = true
        view_gesture_reaset_counter.isHidden = true
        lbl_title_topview.textColor = .white
        lbl_target_topview.textColor = .white
        lbl_reminder_topview.textColor = .white
        databasehelper.sharaintance.saveItems()
    }else if isFromSaveTask == false{
            stackview.isHidden = true
            counting = 0
            lbl_Show_counting_Value.text = "\(counting)"
            view_reset_Counting_bottom_sheet.isHidden = true
            view_gesture_reaset_counter.isHidden = true
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = .clear
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progressview.setProgress(0.0, animated: true)
        
    }
//MARK: - Custem methode
    func AllCutemMethoddeToSet_VIewLoad(){
        lbl_Show_counting_Value.text = "\(counting)"
        lbl_Show_counting_Value.textColor = .white
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music! ))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch{
            print(error)
        }
        appears_Back_Graund_coloure(btn_Sound)
        appears_Back_Graund_coloure(btn_vibration)
        appears_Back_Graund_coloure(btn_list)
        appears_Back_Graund_coloure(btn_change_Mode)
        appears_Back_Graund_coloure(btn_change_view_coloure)
        progressview.progressTintColor = .black
    }
    
    func showalert(){
        let toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/9, 300, 35))
        toastLabel.textColor = .black
        toastLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(toastLabel)
        toastLabel.backgroundColor = counterBorderColor
        toastLabel.text = "Reminder has been reached."
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                   UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                       toastLabel.alpha = 0
                   }, completion: { finished in
                       toastLabel.removeFromSuperview()
                   })
               })
    }
    
    @objc func handle_Tap_Gesture(sender: UITapGestureRecognizer){
        view_reset_Counting_bottom_sheet.isHidden = true
        view_gesture_reaset_counter.isHidden = true
        resetBollian.toggle()
    }
    
    func setupTheme(){
        bgColor = self.colors.randomElement()!
        counterBgColor = self.colors.randomElement()!
        counterBorderColor = self.colors.randomElement()!
        self.view_Main_Grediantcoloure.backgroundColor = bgColor
        self.img_coloure_convertore.backgroundColor = counterBgColor
        btn_pluse_count.backgroundColor = counterBorderColor
        img_coloure_convertore.borderColor = counterBorderColor
        btn_Sound.backgroundColor = selectedsound ? counterBorderColor : .systemBrown
        btn_vibration.backgroundColor = selectedvibration ? counterBorderColor : .systemBrown
        if stackview.isHidden == true{
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = .clear
        }else{
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = isnavigation_bar_coloure_change ? counterBorderColor : .gray
        }
    }
    
func bottom(){
    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.view_reset_Counting_bottom_sheet.frame = CGRect(x: 0, y: 0, width: 393, height: 20)
        }) { (finished) in
            if finished {
                print("finished")
            }
      }
  
    }
    func End_topView_Isactive_False(){
        let ArryList = databasehelper.sharaintance.getdata()
        var _: [()] = ArryList.map({$0.isActive = false})
        
    }
//MARK: -   @IBAction
    //btntapped go sidemenu
    @IBAction func btn_did_tapped_goSideMenu(_ sender: UIBarButtonItem) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        self.navigationController?.pushViewController(nav, animated: false)
    }
  
    @IBAction func btn_did_Tapped_goaddVlyueVc_openEndEditBtn(_ sender: UIButton) {
        let newgetdata_of_database = databasehelper.sharaintance.getdata()
        let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true})
        if GlobalData.sharedInstance.isFromSaveTask == false {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "AddValyueViewController") as! AddValyueViewController
            nav.modalPresentationStyle = .fullScreen
            let convertInt_showcounting_lable = lbl_Show_counting_Value.text
            nav.firstVc_ccurent_list_show_start_value =  convertInt_showcounting_lable!
           self.navigationController?.pushViewController(nav, animated: true)

        }
        else if  GlobalData.sharedInstance.isFromSaveTask == true || newgetdata_of_database[index!].isActive == true{
            if isnavigation_bar_coloure_change{
                view_End_Edit_btn.isHidden = false
                stackview.backgroundColor = .systemBrown
                btn_vnavigationItem_rightbar_BtnItem.backgroundColor = .systemBrown
                btn_vnavigationItem_rightbar_BtnItem.tintColor = .white
                btn_vnavigationItem_rightbar_BtnItem.setImage(UIImage(systemName: "chevron.up"), for: .normal)
                lbl_title_topview.textColor = .black
                lbl_target_topview.textColor = .black
                lbl_reminder_topview.textColor = .black
                isnavigation_bar_coloure_change = false
            }else if !isnavigation_bar_coloure_change{
                view_End_Edit_btn.isHidden = true
                stackview.backgroundColor = .clear
                btn_vnavigationItem_rightbar_BtnItem.backgroundColor = counterBorderColor
                btn_vnavigationItem_rightbar_BtnItem.tintColor = .black
                btn_vnavigationItem_rightbar_BtnItem.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                isnavigation_bar_coloure_change = true
                lbl_title_topview.textColor = .white
                lbl_target_topview.textColor = .white
                lbl_reminder_topview.textColor = .white
            }
        }
    }
    //btntapped pluse counting
    @IBAction func btn_click_addCountind(_ sender: UIButton) {
        let newgetdata_of_database = databasehelper.sharaintance.getdata()
        let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true})
        if index == nil || GlobalData.sharedInstance.isFromSaveTask == false{
                counting = counting + 1
                lbl_Show_counting_Value.text = "\(counting)"
                  }
        else if GlobalData.sharedInstance.isFromSaveTask == true || newgetdata_of_database[index!].isActive == true{
            lbl_Show_counting_Value.text = "\(counting)"
            counting = counting + 1
           let currentCount = (counting ) % Int(current_data_list_obj.reminder)
            let objDtabase = current_data_list_obj
                if counting  >= current_data_list_obj.targetValue{
                    view_gesture_reaset_counter.isHidden = false
                    view_reset_Counting_bottom_sheet.isHidden = false
                    bottom()
                    lbl_resetCounter_bottom_view.text = "Target Reached"
                    lbl_AreYou_sure_boomview.text = "The target value has been reached.Would you like to reset the counter?"
                    counting = Int(current_data_list_obj.targetValue)
                }else if currentCount == 0
                    {
                      showalert()
                    }
                progressview.progress = Float(counting) / Float((objDtabase.targetValue))
                lbl_Show_counting_Value.text = "\(counting)"
                current_data_list_obj.startValue = Int16(counting)
                databasehelper.sharaintance.saveItems()
            }
       
        if selectedsound{
            audioPlayer.play()
        }
        if vibrationbool{
            AudioServicesPlayAlertSound(UInt32(kSystemSoundID_Vibrate))
        }
    }
//btntapped minus counting
    @IBAction func btn_click_minus_counting(_ sender: UIButton)  {
        let newgetdata_of_database = databasehelper.sharaintance.getdata()
        let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true})
        if index == nil || GlobalData.sharedInstance.isFromSaveTask == false{
                if counting > 0{
                    counting = counting - 1
                    lbl_Show_counting_Value.text = "\(counting)"
                }else{
                    counting = 0
                }
            }
        else if  GlobalData.sharedInstance.isFromSaveTask == true || newgetdata_of_database[index!].isActive == true {
            if counting > 0{
                counting = counting - 1
                progressview.progress = Float(counting) / Float(current_data_list_obj.targetValue)
                current_data_list_obj.startValue = Int16(counting)
                lbl_Show_counting_Value.text = "\(counting)"
                databasehelper.sharaintance.saveItems()
            }else{
                    counting = 0
                }
        }
    }
    //btntapped reload counting
    @IBAction func btn_click_reload_conting(_ sender: UIButton) {
                if lbl_Show_counting_Value.text != "0" {
                view_gesture_reaset_counter.isHidden = false
                view_reset_Counting_bottom_sheet.isHidden = false
                bottom()
                lbl_resetCounter_bottom_view.text = "Reaset counter"
                lbl_AreYou_sure_boomview.text = "Are you sure reaset you want to reaset counter?"
                resetBollian.toggle()
                }
    }
           
    @IBAction func btn_resetcount_Yes(_ sender: UIButton) {
        let newgetdata_of_database = databasehelper.sharaintance.getdata()
        let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true})
        if index == nil || GlobalData.sharedInstance.isFromSaveTask == false {
            counting = 0
            lbl_Show_counting_Value.text = "\(counting)"
            view_reset_Counting_bottom_sheet.isHidden = true
            view_gesture_reaset_counter.isHidden = true
            }
        else if  GlobalData.sharedInstance.isFromSaveTask == true || newgetdata_of_database[index!].isActive == true {
            if is_bootom_EndMala{
                stackview.isHidden = true
                view_reset_Counting_bottom_sheet.isHidden = true
                view_gesture_reaset_counter.isHidden = true
                btn_vnavigationItem_rightbar_BtnItem.backgroundColor = .clear
                btn_vnavigationItem_rightbar_BtnItem.tintColor = .white
                btn_vnavigationItem_rightbar_BtnItem.setImage(UIImage(systemName: "doc.plaintext.fill"), for: .normal)
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                counting = 0
                lbl_Show_counting_Value.text = "\(counting)"
                GlobalData.sharedInstance.isFromSaveTask = false
                End_topView_Isactive_False()
                is_bootom_EndMala = false
                databasehelper.sharaintance.saveItems()
                }
            else if counting > 0 {
                counting = counting - counting
                progressview.progress = Float(counting) / Float(current_data_list_obj.targetValue)
                current_data_list_obj.startValue = Int16(counting)
                lbl_Show_counting_Value.text = "\(counting)"
                view_reset_Counting_bottom_sheet.isHidden = true
                view_gesture_reaset_counter.isHidden = true
                stackview.isHidden = false
                databasehelper.sharaintance.saveItems()
            }
        }
    }
    
    @IBAction func btn_resetcount_No(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view_reset_Counting_bottom_sheet.isHidden = true
        }) { [self] (isCompleted) in
            resetBollian.toggle()
            self.view_gesture_reaset_counter.isHidden = true
        }
    }
    
    @IBAction func btn_Hide_Bottom_sheet(_ sender: Any) {
        view_reset_Counting_bottom_sheet.isHidden = true
        view_gesture_reaset_counter.isHidden = true
        resetBollian.toggle()
    }
    
    @IBAction func btn_didtapped_sound(_ sender: UIButton) {
        selectedsound = selectedsound ? false : true
        sender.backgroundColor = selectedsound ? counterBorderColor : .systemBrown
    }
    
    @IBAction func btn_didtapped_vibration(_ sender:UIButton) {
        selectedvibration = selectedvibration ? false : true
        sender.backgroundColor = selectedvibration ? counterBorderColor : .systemBrown
    }
    
    @IBAction func btn_list(_ sender: UIButton) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        let navigationControlr = UINavigationController(rootViewController: nav)
        navigationControlr.modalPresentationStyle = .fullScreen
        //let data = databasehelper.sharaintance.getdata()
      //  let newIndex = data.firstIndex(where: {$0.isActive == true})
        self.present(navigationControlr, animated: true, completion: nil)
        }
    
    @IBAction func btn_colourefull_paint(_ sender: UIButton) {
        selectedcoloure = true
        setupTheme()
        selectedmode = true
        }
    
    @IBAction func btn_mode_dark(_ sender: UIButton) {
        if selectedmode{
            view_Main_Grediantcoloure.backgroundColor = UIColor(named: "dark")
            img_coloure_convertore.backgroundColor = UIColor(named: "dark")
            btn_pluse_count.backgroundColor  = UIColor(named: "dark")
            selectedmode.toggle()
        }else{
            self.view_Main_Grediantcoloure.backgroundColor = bgColor
            self.img_coloure_convertore.backgroundColor = counterBgColor
            btn_pluse_count.backgroundColor = counterBorderColor
            img_coloure_convertore.borderColor = counterBorderColor
            btn_Sound.backgroundColor = selectedsound ? counterBorderColor : .systemBrown
            btn_vibration.backgroundColor = selectedvibration ? counterBorderColor  : .systemBrown
            selectedmode.toggle()
        }
    }
    
    @IBAction func btn_Preyer_End_topview(_ sender: UIButton) {
        is_bootom_EndMala = true
        view_reset_Counting_bottom_sheet.isHidden = false
        view_gesture_reaset_counter.isHidden = false
        bottom()
        lbl_resetCounter_bottom_view.text = "End Counting"
        lbl_AreYou_sure_boomview.text = "Are you sure you want to end this counting?"
    }
    
@IBAction func btn_Preyer_Edit_topview(_ sender: UIButton) {
    GlobalData.sharedInstance.isFromSaveTask = true
   
   let nav = self.storyboard?.instantiateViewController(withIdentifier: "AddValyueViewController") as! AddValyueViewController
        nav.modalPresentationStyle = .fullScreen
        let newgetdata_of_database = databasehelper.sharaintance.getdata()
        if let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true}){
            nav.select_Index_list_Vc_database = index
        }
            nav.is_selectIndex_bool_Dtabase_Edit = false
            nav.isEdit_first_vc_topviewData = true
            self.navigationController?.pushViewController(nav, animated: true)
        }
    
    func appears_Back_Graund_coloure(_ Sender : UIButton){
        Sender.backgroundColor = .systemBrown
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 0.0
        )
    }
}

 extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1  // Swift 3-4: UIWindowLevelAlert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}

