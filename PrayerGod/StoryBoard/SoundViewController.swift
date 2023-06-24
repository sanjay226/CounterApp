//
//  SoundViewController.swift
//  PrayerGod
//
//  Created by macOS on 15/06/23.
//

import UIKit
import Foundation
import AVFoundation

class SoundViewController: UIViewController, AVAudioPlayerDelegate{
  
@IBOutlet weak var tbl_sound_list: UITableView!
    //MARK: - All veriable
    var selectedindex = -1
    var Arrysound = ["sound","sound","sound","sound","sound","sound","sound","sound","sound","sound","sound","sound","sound","sound","sound"]
    //MARK: - view controller lifeccycle
override func viewDidLoad() {
        super.viewDidLoad()
        tbl_sound_list.delegate = self
        tbl_sound_list.dataSource = self
        left_and_right_barButtonItem_Add()
        }
    //MARK: - Custum methode
   func left_and_right_barButtonItem_Add(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(GoRootVc))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .plain, target: self, action: #selector(selected_sound))
        self.navigationItem.rightBarButtonItem?.tintColor = .green
        let backButton1 = UIBarButtonItem()
        backButton1.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton1
        backButton1.tintColor = .white
        title = "Counter Sounds"
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
    
    @objc func selected_sound(){
        UserDefaults.standard.set(selectedindex, forKey: "index")
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}
//MARK:- UITableViewDelegate && UITableViewDataSource methode
extension SoundViewController  : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arrysound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tbl_sound_list.dequeueReusableCell(withIdentifier: "SoundViewCell", for: indexPath) as! SoundViewCell
        cell.lbl_sound_name_list.text = Arrysound[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell  = tbl_sound_list.dequeueReusableCell(withIdentifier: "SoundViewCell") as! SoundViewCell
        cell.Cell_content_view.layer.borderWidth = 2.0
        cell.Cell_content_view.layer.borderColor = UIColor.black.cgColor
        selectedindex = indexPath.row
        playAudio(Arrysound[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell  = tbl_sound_list.dequeueReusableCell(withIdentifier: "SoundViewCell") as! SoundViewCell
        cell.Cell_content_view.layer.borderWidth = 0.0
        cell.Cell_content_view.layer.borderColor = UIColor.clear.cgColor
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func playAudio(_ audioName : String){
           let url = NSURL.fileURL(
               withPath: Bundle.main.path(forResource: audioName,
                                                     ofType: "mp3")!)
           let audioPlayer = try? AVAudioPlayer(contentsOf: url)
           audioPlayer?.delegate = self
           audioPlayer?.prepareToPlay()
        
           if let player = audioPlayer {
               player.play()
           }
       }

 
}





