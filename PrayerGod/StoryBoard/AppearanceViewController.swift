//
//  AppearanceViewController.swift
//  PrayerGod
//
//  Created by macOS on 19/06/23.
//

import UIKit

class AppearanceViewController: UIViewController {
    //MARK: -   @IBOutlet
    @IBOutlet weak var collectionView_coloureThim: UICollectionView!
    //MARK: -   Custem Variable
    var Arr_of_color = [UIColor]()
    var Obj_Colore = UIColor()
    var isbool = Bool()
    //MARK: - aplication life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        left_and_right_barButtonItem_Appeareance()
        collectionView_coloureThim.delegate = self
        collectionView_coloureThim.dataSource = self
        
    }
    //MARK: -   Custem Methode
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
        return Theme_Arry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellAppearanceCollectionViewCell", for: indexPath) as?
            CellAppearanceCollectionViewCell{
            cell.imgInside.image = cell.imgInside.image?.withRenderingMode(.alwaysTemplate)
            cell.imgBorder.image = cell.imgBorder.image?.withRenderingMode(.alwaysTemplate)
            cell.imgBorder.tintColor = UIColor(named: Theme_Arry[indexPath.row].Color_Border)
            cell.imgInside.tintColor = UIColor(named: Theme_Arry[indexPath.row].Color_img_inside)
            cell.vwBackGround.backgroundColor = UIColor(named: Theme_Arry[indexPath.row].Color_background)
            cell.vwBtnPlus.backgroundColor = UIColor(named: Theme_Arry[indexPath.row].Color_Border)
            if ThemeIndex == indexPath.row{
                cell.layer.borderWidth = 3.0
                cell.layer.borderColor = UIColor.white.cgColor
            }else{
                cell.layer.borderWidth = 0.0
                cell.layer.borderColor = UIColor.white.cgColor
            }
            return cell
        }
        return UICollectionViewCell()
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
        ThemeIndex = indexPath.row
        UserDefaults.standard.set(ThemeIndex, forKey: "ThimIndex")
        collectionView.reloadData()
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
