//
//  SoundViewController.swift
//  PrayerGod
//
//  Created by macOS on 15/06/23.
//

import UIKit
import Foundation
import AVFoundation

class SoundViewController: UIViewController{
  
@IBOutlet weak var tbl_sound_list: UITableView!
    //MARK: - All veriable
    var selectedindex = -1
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tbl_sound_list.delegate = self
        tbl_sound_list.dataSource = self
        left_and_right_barButtonItem_Add()
       
        }
    
    
   func left_and_right_barButtonItem_Add(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(GoRootVc))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .plain, target: self, action: #selector(gosidemenu))
        self.navigationItem.rightBarButtonItem?.tintColor = .green
        let backButton1 = UIBarButtonItem()
        backButton1.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton1
        backButton1.tintColor = .white
        title = "Counter Sounds"
        let textAttributes1 = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes1
       
    }
//MARK: - Custum methode
    @objc func GoRootVc(){
        
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func gosidemenu(){
        
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
  
}

extension SoundViewController  : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tbl_sound_list.dequeueReusableCell(withIdentifier: "SoundViewCell", for: indexPath) as! SoundViewCell
        cell.lbl_sound_name_list.text = "jsdfi"
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedindex = indexPath.row
        UserDefaults.standard.set(selectedindex, forKey: "index")
    }
 }





