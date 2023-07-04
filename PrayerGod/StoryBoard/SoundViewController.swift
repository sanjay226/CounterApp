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
    var selectedindex = 0
    var Arrysound = Array(repeating: "sound", count: 15)
    var audioPlayer = AVAudioPlayer()
    //MARK: - view controller lifeccycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_sound_list.delegate = self
        tbl_sound_list.dataSource = self
        left_and_right_barButtonItem_Add()
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#222222")
        selectedindex = UserDefaults.standard.integer(forKey: "index")
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
        if selectedindex == indexPath.row{
            cell.Cell_content_view.borderWidth = 3.0
            cell.Cell_content_view.borderColor = .white
        }else{
            cell.Cell_content_view.borderWidth = 0.0
            cell.Cell_content_view.borderColor = .clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedindex = indexPath.row
        do {
            if let url = Bundle.main.url(forResource: Arrysound[indexPath.row], withExtension: "mp3"){
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
                try AVAudioSession.sharedInstance().setActive(true)
                audioPlayer.play()                
            }
        }
        catch{
            print(error)
        }
        tbl_sound_list.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        audioPlayer.stop()
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func playAudio(_ audioName : String, _ type : String){
        //        if let url = Bundle.main.url(forResource: audioName, withExtension: "mp3"){
        //            //        NSURL.fileURL(withPath: Bundle.main.path(forResource: audioName, ofType: "mp3")!)
        //
        //            do{
        //                let audioPlayer = try AVAudioPlayer(contentsOf: url)
        //                //        audioPlayer?.delegate = self
        //                // audioPlayer?.prepareToPlay()
        //
        //               DispatchQueue.main.async {
        ////                    if let player = audioPlayer {
        //                audioPlayer.play()
        //                print("play sound")
        //                  }
        ////                }
        //
        //            }catch{
        //                print(error.localizedDescription)
        //            }
        //  let audioPlayer = try? AVAudioPlayer(contentsOf: url)
        //        audioPlayer?.delegate = self
        // audioPlayer?.prepareToPlay()
        //
        //            DispatchQueue.main.async {
        //                if let player = audioPlayer {
        //                    player.play()
        //                    print("play sound")
        //                }
        //            }
        //
        
    }
    
    
}





