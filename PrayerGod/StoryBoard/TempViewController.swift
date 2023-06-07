//
//  TempViewController.swift
//  PrayerGod
//
//  Created by macOS on 03/06/23.
//

import UIKit

class TempViewController: UIViewController {
    
    @IBOutlet weak var vir: UIView!
    lazy var sidemenupending: CGFloat = self.view.frame.height * 0.45
    override func viewDidLoad() {
        super.viewDidLoad()
   
      
    }
    
    @IBAction func btnhide(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.vir.center.y += self.vir.frame.height
           }
    }
    
    @IBAction func btn_sho(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.vir.center.y -= self.vir.frame.height
           }
        
    }
}
    extension UIView{
        func animShow(){
            UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                           animations: {
                self.center.y -= self.bounds.height
                self.layoutIfNeeded()
            }, completion: nil)
            self.isHidden = false
        }
        func animHide(){
            UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                           animations: {
                self.center.y += self.bounds.height
                self.layoutIfNeeded()
                
            },  completion: {(_ completed: Bool) -> Void in
                self.isHidden = true
            })
        }
    }

