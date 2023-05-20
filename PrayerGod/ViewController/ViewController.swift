//
//  ViewController.swift
//  PrayerGod
//
//  Created by macOS on 16/04/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    //MARK: -   @IBOutlet
    @IBOutlet weak var view_Main_Grediantcoloure: UIView!
    @IBOutlet weak var btn_pluse_count: UIButton!
    @IBOutlet weak var btn_minus_count: UIButton!
    @IBOutlet weak var btn_Reload_count: UIButton!
    @IBOutlet weak var lbl_Show_counting_Valyue: UILabel!
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
    @IBOutlet weak var btn_vnavigationItem_rightbar_BtnItem: UIBarButtonItem!
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
    var strtvalyueofprogresview = Float()
    var count_current_value = Bool()
    var End_progresscount = Float()
   // var progresstotal_count_min = Float()
    //MARK: - Application lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AllCutemMethoddeToSet_VIewLoad()
    
   
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
      
        let isFromSaveTask = GlobalData.sharedInstance.isFromSaveTask ?? false
       
        if isFromSaveTask {
            count_current_value = false
            stackview.isHidden = false
            lbl_title_topview.text = databasehelper.sharaintance.getdata().last?.title
            lbl_target_topview.text = "\(databasehelper.sharaintance.getdata().last?.targetValue ?? 0)"
            lbl_reminder_topview.text = "\(databasehelper.sharaintance.getdata().last?.reminder ?? 0)"
            strtvalyueofprogresview = (Float(databasehelper.sharaintance.getdata().last?.startValue ?? 0) / Float(databasehelper.sharaintance.getdata().last?.targetValue ?? 0))
            
            GlobalData.sharedInstance.isFromSaveTask = false
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
            progressview.setProgress(strtvalyueofprogresview, animated: true)
            counting = Int(databasehelper.sharaintance.getdata().last!.startValue)
            print("startvalue \(databasehelper.sharaintance.getdata().last!.startValue ?? 0), tergetvalue \(databasehelper.sharaintance.getdata().last?.targetValue ?? 0)")
            lbl_Show_counting_Valyue.text = "\(counting)"
        }else{
            count_current_value = true
            stackview.isHidden = true
            counting = 0
            lbl_Show_counting_Valyue.text = "\(counting)"
      }
    }
//MARK: - Custem methode
    func AllCutemMethoddeToSet_VIewLoad(){
        lbl_Show_counting_Valyue.text = "\(counting)"
        lbl_Show_counting_Valyue.textColor = .white
        view_reset_Counting_bottom_sheet.isHidden = true
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
    }
    
    func bottom()  {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
            self.view_reset_Counting_bottom_sheet.frame = CGRect(x: 0, y: 0, width: 393, height: 20)
        }) { (finished) in
            if finished {
                print("finished")
            }
        }
    }
//MARK: -   @IBAction
    //btntapped go sidemenu
    @IBAction func btn_did_tapped_goSideMenu(_ sender: UIBarButtonItem) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        self.navigationController?.pushViewController(nav, animated: false)
    }
    //btntapped go sidemenu
    @IBAction func btn_did_Tapped_goaddVlyueVc(_ sender: UIBarButtonItem) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "AddValyueViewController") as! AddValyueViewController
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(nav, animated: true)
    }
    //btntapped pluse counting
    @IBAction func btn_click_addCountind(_ sender: UIButton) {
        if count_current_value == false{
            print("startvalue btn click first \(databasehelper.sharaintance.getdata().last!.startValue ?? 0), tergetvalue  btn click first\(databasehelper.sharaintance.getdata().last?.targetValue ?? 0)")
            let objDtabase = databasehelper.sharaintance.getdata().last
            
            databasehelper.sharaintance.getdata().last?.startValue += 1
           
            progressview.progress = Float(objDtabase!.startValue) / Float(objDtabase!.targetValue)
            lbl_Show_counting_Valyue.text = "\(counting)"
            print("startvalue btn click \(databasehelper.sharaintance.getdata().last!.startValue ?? 0), tergetvalue  btn click\(databasehelper.sharaintance.getdata().last?.targetValue ?? 0)")
        }else if count_current_value == true{
            counting = counting + 1
            lbl_Show_counting_Valyue.text = "\(counting)"
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
        if counting > 0{
            counting = counting - 1
            lbl_Show_counting_Valyue.text = "\(counting)"
        }else{
            counting = 0
        }}
    //btntapped pluse counting
    @IBAction func btn_click_reload_conting(_ sender: UIButton) {
        
        if resetBollian {
            if lbl_Show_counting_Valyue.text != "0" {
                view_reset_Counting_bottom_sheet.isHidden = false
                bottom()
                resetBollian.toggle()
                
            }
        }else{
            view_reset_Counting_bottom_sheet.isHidden = true
            resetBollian.toggle()
        }
        
    }
    
    @IBAction func btn_resetcount_Yes(_ sender: UIButton) {
        counting = 0
        lbl_Show_counting_Valyue.text = "\(counting)"
        view_reset_Counting_bottom_sheet.isHidden = true
        resetBollian.toggle()
    }
    
    @IBAction func btn_resetcount_No(_ sender: UIButton) {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            self.view_reset_Counting_bottom_sheet.isHidden = true
            
        }) { [self] (isCompleted) in
            resetBollian.toggle()
        }
    }
    
    @IBAction func btn_Hide_Bottom_sheet(_ sender: Any) {
        view_reset_Counting_bottom_sheet.isHidden = true
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



