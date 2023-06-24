//
//  AppearanceViewController.swift
//  PrayerGod
//
//  Created by macOS on 19/06/23.
//

import UIKit

class AppearanceViewController: UIViewController {
    
    @IBOutlet weak var collectionView_coloureThim: UICollectionView!
   
    var Arr_of_color = [UIColor]()
    var Obj_Colore = UIColor()
    var isbool = Bool()
    
 override func viewDidLoad() {
        super.viewDidLoad()
        left_and_right_barButtonItem_Appeareance()
        collectionView_coloureThim.delegate = self
        collectionView_coloureThim.dataSource = self
     Arr_of_color = [.systemRed,.blue,.gray,.brown,.orange,.cyan,.systemBrown,.systemRed,.systemBlue,.systemPink,.magenta,.systemTeal,.tintColor,.green,.lightGray]
       
    }
    
    func left_and_right_barButtonItem_Appeareance(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(Go_SideMenu_Vc))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        let backButton1 = UIBarButtonItem()
        backButton1.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton1
        backButton1.tintColor = .white
        title = "Appearance"
        let textAttributes1 = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes1
    }
    
    @objc func Go_SideMenu_Vc(){
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}
//MARK:- UICollectionViewDataSource &&  UICollectionViewDelegateFlowLayou
extension AppearanceViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Arr_of_color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellAppearanceCollectionViewCell", for: indexPath) as!
        CellAppearanceCollectionViewCell
       cell.view_content_in_cell_inside.backgroundColor = Arr_of_color[indexPath.row]
   
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: self.view.bounds.width/2-15, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Obj_Colore = Arr_of_color[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.white.cgColor
        UserDefaults.standard.set(Obj_Colore, forKey: "obj_colore_thim")
        isbool = true
        UserDefaults.standard.set(isbool, forKey: "isslectApperwanceColore")
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
        cell?.layer.borderColor = UIColor.clear.cgColor
        isbool = false
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {

        return true
        
    }
}
//MARK:- All extension
extension UIColor {
    static var randomcolor: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}

extension UserDefaults {

    func color(forKey key: String) -> UIColor? {

        guard let colorData = data(forKey: key) else { return nil }

        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
        } catch let error {
            print("color error \(error.localizedDescription)")
            return nil
        }

    }
    

func set(_ value: UIColor?, forKey key: String) {

        guard let color = value else { return }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
            set(data, forKey: key)
        } catch let error {
            print("error color key data not saved \(error.localizedDescription)")
        }

    }

}
