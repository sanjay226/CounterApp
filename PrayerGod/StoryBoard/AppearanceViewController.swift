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
     Arr_of_color = [#colorLiteral(red: 1, green: 0.537254902, blue: 0.8470588235, alpha: 1),  #colorLiteral(red: 0, green: 0.9909999967, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.3289999962, blue: 0.5749999881, alpha: 1), #colorLiteral(red: 1, green: 0.8320000172, blue: 0.47299999, alpha: 1), #colorLiteral(red: 0.7540000081, green: 0.7540000081, blue: 0.7540000081, alpha: 1), #colorLiteral(red: 1, green: 0.1490000039, blue: 0, alpha: 1), #colorLiteral(red: 0.824000001, green: 0.5910000205, blue: 0.3670000136, alpha: 1), #colorLiteral(red: 0.4440000057, green: 0.1340000033, blue: 0.3079999983, alpha: 1), #colorLiteral(red: 1, green: 0.5759999752, blue: 0, alpha: 1), #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1), #colorLiteral(red: 0.5529411765, green: 0.9764705882, blue: 0, alpha: 1), #colorLiteral(red: 0.9977686405, green: 0.8496080637, blue: 0.9562239647, alpha: 1), #colorLiteral(red: 0.4768145084, green: 0.5168155432, blue: 0.5, alpha: 1)]
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
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#222222")
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
        cell.img_only_counter_border.image = cell.img_only_counter_border.image?.withRenderingMode(.alwaysTemplate)
        cell.view_content_in_cell_inside.backgroundColor = Arr_of_color[indexPath.row]
        cell.img_only_counter_border.tintColor = .black
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = self.collectionView_coloureThim.bounds.width
        return CGSize(width: width / 2 - 14, height: 260)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Obj_Colore = Arr_of_color[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 3.0
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
    
    private func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
//MARK:- All extension
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
