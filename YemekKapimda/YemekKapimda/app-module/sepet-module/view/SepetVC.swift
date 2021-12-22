//
//  SepetVC.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 8.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class SepetVC: UIViewController {
    
    @IBOutlet weak var sepetTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var kullaniciAdiLabel: UILabel!
    @IBOutlet weak var sepetOnay: UIButton!
    var yemekler = [SepetYemekler]()
    var sepetPresenterNesnesi:ViewToPresenterSepetProtocol?
    var fiyat = 0
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        SepetRouter.createModule(ref: self)
        kullaniciAdiLabel.text = defaults.object(forKey: "username") as? String
        sepetOnay.layer.cornerRadius = 10
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        sepetPresenterNesnesi?.yemekleriYukle(kullaniciadi: kullaniciAdiLabel.text!)
        get_total()
    }
    @IBAction func silButton(_ sender: Any) {
        sil()
    }
    @IBAction func toAnaSayfaButton(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
      
    }
    
    func get_total(){
        var iterator = 1
        var toplam = 0
        fiyat = 0
        while iterator <= yemekler.count {
            fiyat = Int(yemekler[iterator-1].yemek_fiyat)! * Int(yemekler[iterator-1].yemek_siparis_adet)!
            toplam += fiyat
            iterator += 1
        }
        totalLabel.text = "Toplam Sepet Tutari:\(toplam)₺"
    }
    func sil(){
        for yemek in yemekler {
            sepetPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id, kullanici_adi: yemek.kullanici_adi)
        }
    }
    
}

extension SepetVC:PresenterToViewSepetProtocol{
    func vieweVeriGonder(yemeklerListesi: Array<SepetYemekler>) {
        self.yemekler = yemeklerListesi
        DispatchQueue.main.async {
            self.sepetTableView.reloadData()
            self.get_total()
        }
    }
}
extension SepetVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = yemekler[indexPath.row]
        let cell = sepetTableView.dequeueReusableCell(withIdentifier: "SepetHucre") as! SepetHucre
        cell.yemekAdLabel.text = yemek.yemek_adi
        fiyat = Int(yemek.yemek_siparis_adet)! * Int(yemek.yemek_fiyat)!
        cell.fiyatLabel.text = "\(yemek.yemek_fiyat)"
        cell.adetLabel.text = "\(yemek.yemek_siparis_adet)"
        cell.totalFiyatLabel.text = "Tutar:\(fiyat)₺"
        cell.stepper.value = Double(yemek.yemek_siparis_adet)!
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi)"){
            DispatchQueue.main.async {
                cell.sepetImage.kf.setImage(with: url)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "SİL"){ (UIContextualAction,view,bool) in
            let yemek = self.yemekler[indexPath.row]
            let alert = UIAlertController(title: "Silme Islemi", message: "\(yemek.yemek_adi) silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "Iptal", style: .cancel) { action in
                
            }
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.sepetPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id, kullanici_adi: yemek.kullanici_adi)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    
}
extension SepetVC{
    
}
