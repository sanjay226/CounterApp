//
//  ViewController.swift
//  PrayerGod
//
//  Created by macOS on 16/04/23.
//

import UIKit
import AVFoundation
import CoreData

var ThemeIndex = 0
//todayscode
class ViewController: UIViewController, AVAudioPlayerDelegate{
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
    @IBOutlet weak var view_lable_zero: UIView!
    @IBOutlet weak var btn_yes_bottomview: UIButton!
    @IBOutlet weak var btn_no_bottom_view: UIButton!
    @IBOutlet weak var lbl_sixZero: UILabel!
    @IBOutlet weak var img_counter_inside_counterImg: UIImageView!
    @IBOutlet weak var btn_botoomview_topside_cansal: UIButton!
    
    //MARK: - All veriable
    var arry_panding_Image = ["volume.1","video.square","list.bullet.rectangle","paintpalette.fill","homekit"]
    var counting = Int()
    var selectedsound = false
    var selectedvibration = false
    var selectedlist = false
    var selectedcoloure = false
    var isDarkMode = false
    var resetBollian = true
    var colourevibrationcount = false
    var audioPlayer = AVAudioPlayer()
    let music = Bundle.main.path(forResource: "sound", ofType: "mp3")
    var i = 1
    var selected_rendom_colore_use_darkmode = UIColor()
    var counterBgColor = UIColor()
    var counterBorderColor = UIColor()
    var current_data_list_obj = Garland()
    var strtvalueofprogresview = Float()
    var End_progresscount = Float()
    var is_bootom_EndMala = Bool()
    lazy var isnavigation_bar_coloure_change = Bool()
    var Arry_diffrent_system_sound = ["sound","Beep","dropBottel","GunShuter","Knock","FastKnock","soundThriller","MidiumCnock","DropingWench","CensorBeep"]
    
    //MARK: - Application lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AllCutemMethoddeToSet_VIewLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handle_Tap_Gesture(sender:)))
        let Switch_tuch = UITapGestureRecognizer(target: self, action: #selector(Handal_swich_On(sender:)))
        view_gesture_reaset_counter.addGestureRecognizer(tapGesture)
        view_Main_Grediantcoloure.addGestureRecognizer(Switch_tuch)
        view_gesture_reaset_counter.isHidden = true
        allbtn_Give_tintColor_progarametically()
        
        if  UserDefaults.standard.object(forKey: "is_selected_sound") == nil{
            UserDefaults.standard.set(true, forKey: "is_selected_sound")
        }
        if  UserDefaults.standard.object(forKey: "is_selected_vibration") == nil{
            UserDefaults.standard.set(true, forKey: "is_selected_vibration")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view_gesture_reaset_counter.isHidden = true///new
        view_reset_Counting_bottom_sheet.isHidden = true///new
        view_End_Edit_btn.isHidden = true
        let isFromSaveTask = GlobalData.sharedInstance.isFromSaveTask ?? false
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
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progressview.setProgress(0.0, animated: true)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ShowColoreviewVillAppeares()
        isDarkMode =  UserDefaults.standard.bool(forKey: "isSelectedDarkModeViewWillAppeare")
        ThemeIndex = UserDefaults.standard.integer(forKey: "ThimIndex")
        if (isDarkMode) {
            setIs_selected()
            allMethode_DarkMode_While_viewWillAppear()
            view_lable_zero.backgroundColor = isDarkMode ? .green :  UIColor(white: 2, alpha: 0.10)
        }else {
            allMethode_colorefull_paint_While_viewWillAppear()
        }
    }
    //MARK: - Custem methode
    func AllCutemMethoddeToSet_VIewLoad(){
        lbl_Show_counting_Value.text = "\(counting)"
        lbl_Show_counting_Value.textColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music!))
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
    
    func allbtn_Give_tintColor_progarametically(){
        img_coloure_convertore.image = img_coloure_convertore.image?.withRenderingMode(.alwaysTemplate)
        img_counter_inside_counterImg.image =  img_counter_inside_counterImg.image?.withRenderingMode(.alwaysTemplate)
        counterBgColor = UIColor(named: Theme_Arry[ThemeIndex].Color_img_inside)!
        counterBorderColor = UIColor(named: Theme_Arry[ThemeIndex].Color_Border)!
        view_Main_Grediantcoloure.backgroundColor = UIColor(named: Theme_Arry[ThemeIndex].Color_background)
    }
    func ShowColoreviewVillAppeares(){
        counterBgColor = UIColor(named: Theme_Arry[ThemeIndex].Color_img_inside)!
        counterBorderColor = UIColor(named: Theme_Arry[ThemeIndex].Color_Border)!
        view_Main_Grediantcoloure.backgroundColor = UIColor(named: Theme_Arry[ThemeIndex].Color_background)
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
    
    func setIs_selected(){
        selectedsound =  UserDefaults.standard.bool(forKey: "is_selected_sound")
        selectedvibration = UserDefaults.standard.bool(forKey: "is_selected_vibration")
        btn_Sound.backgroundColor = selectedsound ?  UIColor(hex: "#FED8F3") : .systemBrown
        btn_vibration.backgroundColor = selectedvibration ?  UIColor(hex: "#FED8F3") : .systemBrown
    }
    
    func allMethode_colorefull_paint_While_viewWillAppear(){
        setIs_selected()
        btn_Sound.backgroundColor = selectedsound ? UIColor(named: Theme_Arry[ThemeIndex].Color_Border): .systemBrown
        btn_vibration.backgroundColor = selectedvibration ? UIColor(named: Theme_Arry[ThemeIndex].Color_Border) : .systemBrown
        self.img_counter_inside_counterImg.tintColor = UIColor(named: Theme_Arry[ThemeIndex].Color_img_inside)
        btn_pluse_count.backgroundColor = UIColor(named: Theme_Arry[ThemeIndex].Color_Border)
        img_coloure_convertore.tintColor = UIColor(named: Theme_Arry[ThemeIndex].Color_Border)
        if stackview.isHidden == true{
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = UIColor(hex: "#2E2E2E")
        }else{
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = isnavigation_bar_coloure_change ? UIColor(named: Theme_Arry[ThemeIndex].Color_Border) : .gray
        }
    }
    
    func allMethode_DarkMode_While_viewWillAppear(){
        view_Main_Grediantcoloure.backgroundColor = UIColor(named: "dark")
        img_counter_inside_counterImg.tintColor = UIColor(named: "dark")
        btn_pluse_count.backgroundColor = .gray
        img_coloure_convertore.tintColor = .gray
        btn_change_Mode.backgroundColor = .gray
        btn_vnavigationItem_rightbar_BtnItem.backgroundColor =  isnavigation_bar_coloure_change ? .gray : .systemBrown
        btn_Sound.backgroundColor = selectedsound ? .gray : .systemBrown
        btn_vibration.backgroundColor = selectedvibration ? .gray : .systemBrown
    }
    
    func  allMethode_SidemenuAppreance_While_viewWillAppear(){
        ThemeIndex = UserDefaults.standard.integer(forKey: "ThimIndex")
        btn_Sound.backgroundColor = selectedsound ? UIColor(named: Theme_Arry[ThemeIndex].Color_Border) : .systemBrown
        btn_vibration.backgroundColor = selectedvibration ? UIColor(named:Theme_Arry[ThemeIndex].Color_Border) : .systemBrown
        view_Main_Grediantcoloure.backgroundColor = UIColor(named:Theme_Arry[ThemeIndex].Color_background)
        img_counter_inside_counterImg.tintColor = UIColor(named:Theme_Arry[ThemeIndex].Color_img_inside)
        isDarkMode = false
        btn_change_Mode.backgroundColor = .systemBrown
    }
    
    @objc func handle_Tap_Gesture(sender: UITapGestureRecognizer){
        view_reset_Counting_bottom_sheet.isHidden = true
        view_gesture_reaset_counter.isHidden = true
        resetBollian.toggle()
    }
    
    @objc func Handal_swich_On(sender: UITapGestureRecognizer){
        let myswitchBoolValuefrom_SideMevuVc : Bool = UserDefaults.standard.bool(forKey: "mySwitch")
        print(myswitchBoolValuefrom_SideMevuVc,"myswitchBoolValuefrom_SideMevuVc ,switch")
        if myswitchBoolValuefrom_SideMevuVc == true{
            add_counting_button()
            if selectedsound{
                audioPlayer.play()
            }
            btn_pluse_count.isUserInteractionEnabled = false
        }else{
            btn_pluse_count.isUserInteractionEnabled = true
            return
        }
    }
    
    func setupTheme(){
        view_Main_Grediantcoloure.backgroundColor = UIColor(named: Theme_Arry[ThemeIndex].Color_background)
        self.img_counter_inside_counterImg.tintColor =  UIColor(named: Theme_Arry[ThemeIndex].Color_img_inside)
        btn_pluse_count.backgroundColor = UIColor(named: Theme_Arry[ThemeIndex].Color_Border)
        img_coloure_convertore.tintColor = UIColor(named: Theme_Arry[ThemeIndex].Color_Border)
        btn_Sound.backgroundColor = selectedsound ? UIColor(named: Theme_Arry[ThemeIndex].Color_Border) : .systemBrown
        btn_vibration.backgroundColor = selectedvibration ? UIColor(named: Theme_Arry[ThemeIndex].Color_Border): .systemBrown
        view_lable_zero.backgroundColor = isDarkMode ? .green :  UIColor(white: 2, alpha: 0.10)
        if stackview.isHidden == true{
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = UIColor(hex: "#2E2E2E")
        }else{
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = isnavigation_bar_coloure_change ? UIColor(named: Theme_Arry[ThemeIndex].Color_Border) : .gray
        }
        UserDefaults.standard.set(ThemeIndex, forKey: "ThimIndex")
        
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
    
    func add_counting_button(){
        let newgetdata_of_database = databasehelper.sharaintance.getdata()
        let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true})
        if index == nil || GlobalData.sharedInstance.isFromSaveTask == false{
            counting = counting + 1
            lbl_Show_counting_Value.text = "\(counting)"
        }else if GlobalData.sharedInstance.isFromSaveTask == true || newgetdata_of_database[index!].isActive == true{
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
            current_data_list_obj.startValue = Int32(counting)
            databasehelper.sharaintance.saveItems()
        }
        if selectedvibration{
            setHeptic_FeedBack(feedbackStyle: .medium)
        }
    }
    
    func setHeptic_FeedBack(feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle = .light){
        let impactMed = UIImpactFeedbackGenerator(style: feedbackStyle)
        impactMed.impactOccurred()
    }
    //MARK: -   @IBAction
    //btntapped go sidemenu
    @IBAction func btn_did_tapped_goSideMenu(_ sender: UIBarButtonItem) {
        setHeptic_FeedBack()
        if let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController{
            let navigationControlr = UINavigationController(rootViewController: nav)
            navigationControlr.modalPresentationStyle = .fullScreen
            self.present(navigationControlr, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_did_Tapped_goaddVlyueVc_openEndEditBtn(_ sender: UIButton) {
        setHeptic_FeedBack()
        let newgetdata_of_database = databasehelper.sharaintance.getdata()
        let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true})
        if GlobalData.sharedInstance.isFromSaveTask == false {
            if let nav = self.storyboard?.instantiateViewController(withIdentifier: "AddValyueViewController") as? AddValyueViewController{
                nav.modalPresentationStyle = .fullScreen
                let convertInt_showcounting_lable = lbl_Show_counting_Value.text
                nav.firstVc_ccurent_list_show_start_value =  convertInt_showcounting_lable!
                self.navigationController?.pushViewController(nav, animated: true)
            }
        }else if  GlobalData.sharedInstance.isFromSaveTask == true || newgetdata_of_database[index!].isActive == true{
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
        if ((UserDefaults.standard.integer(forKey: "index")) != 0){
            selectedsound = false
            let indexof_Defoult  = UserDefaults.standard.integer(forKey: "index")
            add_counting_button()
            do {
                if let url = Bundle.main.url(forResource: Arry_diffrent_system_sound[indexof_Defoult], withExtension: "mp3"){
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer.play()
                }
            }
            catch{
                print(error)
            }
        }
        else{
            add_counting_button()
            if selectedsound{
                audioPlayer.play()
            }
        }
    }
    
//    func playAudio(_ audioName : String){
//        let url = NSURL.fileURL(
//            withPath: Bundle.main.path(forResource: audioName,
//                                       ofType: "mp3")!)
//        let audioPlayer = try? AVAudioPlayer(contentsOf: url)
//        audioPlayer?.delegate = self
//        audioPlayer?.prepareToPlay()
//        if let player = audioPlayer {
//            player.play()
//        }
//    }
    //btntapped minus counting
    @IBAction func btn_click_minus_counting(_ sender: UIButton)  {
        setHeptic_FeedBack()
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
                current_data_list_obj.startValue = Int32(counting)
                lbl_Show_counting_Value.text = "\(counting)"
                databasehelper.sharaintance.saveItems()
            }else{
                counting = 0
            }
        }
    }
    //btntapped reload counting
    @IBAction func btn_click_reload_conting(_ sender: UIButton) {
        setHeptic_FeedBack()
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
                btn_vnavigationItem_rightbar_BtnItem.backgroundColor = UIColor(hex: "#2E2E2E")
                btn_vnavigationItem_rightbar_BtnItem.tintColor = .white
                btn_vnavigationItem_rightbar_BtnItem.setImage(UIImage(systemName: "plus"), for: .normal)
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
                current_data_list_obj.startValue = Int32((counting))
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
        setHeptic_FeedBack()
        selectedsound = selectedsound ? false : true
        if isDarkMode{
            sender.backgroundColor = selectedsound ? .gray : .systemBrown
        }else{
            sender.backgroundColor = selectedsound ? counterBorderColor : .systemBrown
        }
        UserDefaults.standard.set(selectedsound ,forKey: "is_selected_sound")
        UserDefaults.standard.synchronize()
        
    }
    
    @IBAction func btn_didtapped_vibration(_ sender:UIButton) {
        setHeptic_FeedBack()
        selectedvibration = selectedvibration ? false : true
        if isDarkMode{
            sender.backgroundColor = selectedvibration ? .gray : .systemBrown
        }else{
            sender.backgroundColor = selectedvibration ? counterBorderColor : .systemBrown
            
        }
        UserDefaults.standard.set(selectedvibration ,forKey: "is_selected_vibration")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func btn_list(_ sender: UIButton) {
        setHeptic_FeedBack()
        if let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController{
            let navigationControlr = UINavigationController(rootViewController: nav)
            navigationControlr.modalPresentationStyle = .fullScreen
            self.present(navigationControlr, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_colourefull_paint(_ sender: UIButton) {
        
        if ThemeIndex == Theme_Arry.count-1{
            ThemeIndex = 0
        }else{
            ThemeIndex = ThemeIndex + 1
        }
        setHeptic_FeedBack()
        isDarkMode = false
        btn_change_Mode.backgroundColor = .systemBrown
        selectedcoloure = true
        setupTheme()
    }
    
    @IBAction func btn_mode_dark(_ sender: UIButton) {
        isDarkMode = !isDarkMode
        UserDefaults.standard.set(isDarkMode, forKey: "isSelectedDarkModeViewWillAppeare")
        setHeptic_FeedBack()
        if (isDarkMode) {
            view_Main_Grediantcoloure.backgroundColor = UIColor(named: "dark")
            img_counter_inside_counterImg.tintColor = UIColor(named: "dark")
            btn_Sound.backgroundColor = selectedsound ? .gray : .systemBrown
            btn_vibration.backgroundColor = selectedvibration ? .gray : .systemBrown
            btn_pluse_count.backgroundColor = .gray
            img_coloure_convertore.tintColor = .gray
        }
        else if !selectedcoloure{
            view_Main_Grediantcoloure.backgroundColor =  UIColor(named: Theme_Arry[ThemeIndex].Color_background)
            img_counter_inside_counterImg.tintColor =  UIColor(named: Theme_Arry[ThemeIndex].Color_img_inside)
            btn_pluse_count.backgroundColor =  UIColor(named: Theme_Arry[ThemeIndex].Color_Border)
        }else if selectedcoloure{
            ThemeIndex = UserDefaults.standard.integer(forKey: "ThimIndex")
            setupTheme()
        }
        btn_change_Mode.backgroundColor = isDarkMode ? .gray : .systemBrown
        view_lable_zero.backgroundColor = isDarkMode ? .green :  UIColor(white: 2, alpha: 0.10)
        if isDarkMode {
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor =  isnavigation_bar_coloure_change ? .gray : .systemBrown
        }else if !isDarkMode{
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = isnavigation_bar_coloure_change ? counterBorderColor : .systemBrown
        }else{
            btn_vnavigationItem_rightbar_BtnItem.backgroundColor = isnavigation_bar_coloure_change ? UIColor(hex: "£2E2E2E") : .systemBrown
        }
        var index = UserDefaults.standard.integer(forKey: "ThimIndex")
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
        if let nav = self.storyboard?.instantiateViewController(withIdentifier: "AddValyueViewController") as? AddValyueViewController{
            nav.modalPresentationStyle = .fullScreen
            let newgetdata_of_database = databasehelper.sharaintance.getdata()
            if let index = newgetdata_of_database.firstIndex(where: {$0.isActive == true}){
                nav.select_Index_list_Vc_database = index
            }
            nav.is_selectIndex_bool_Dtabase_Edit = false
            nav.isEdit_first_vc_topviewData = true
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    
    func appears_Back_Graund_coloure(_ Sender : UIButton){
        Sender.backgroundColor = .systemBrown
    }
}
//MARK:- All extension
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
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

