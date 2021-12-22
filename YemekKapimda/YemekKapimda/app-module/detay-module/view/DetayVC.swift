 //
 //  DetayVC.swift
 //  YemekKapimda
 //
 //  Created by Asit Aslan on 8.12.2021.
 //  Copyright © 2021 Asit Aslan. All rights reserved.
 //
 
 import UIKit
 import Kingfisher
 class DetayVC: UIViewController{
    
    @IBOutlet weak var yemekImage: UIImageView!
    @IBOutlet weak var adLabael: UILabel!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var adetLabel: UILabel!
    @IBOutlet weak var sepeteEkleButton: UIButton!
    @IBOutlet weak var toplamTutarLabel: UILabel!
    var yemek:Yemekler?
    var yemekListe = [SepetYemekler]()
    let defaults = UserDefaults.standard
    var detayPresenterNesnesi: ViewToPresenterDetayProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let y = yemek {
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi)"){
                DispatchQueue.main.async {
                    self.yemekImage.kf.setImage(with: url)
                   
                }
            }
            adLabael.text = y.yemek_adi
            fiyatLabel.text = "\(y.yemek_fiyat)₺"
            navigationItem.title = y.yemek_adi
        }
        DetayRouter.createModule(ref: self)
        yemekImage.layer.cornerRadius = yemekImage.frame.size.height/2
        sepeteEkleButton.layer.cornerRadius = 8
    }
    override func viewWillAppear(_ animated: Bool) {
        if let yk = defaults.object(forKey: "username"){
            detayPresenterNesnesi?.yemekleriYukle(kullanici_adi: yk as! String)
        }
        total()
    }
    
    @IBAction func sepeteEkle(_ sender: Any) {
        ekle()
    }
    @IBAction func adetStepper(_ sender: UIStepper) {
        adetLabel.text = String(Int(sender.value))
        total()
    }
    func total(){
        let fiyat = Int(yemek!.yemek_fiyat)!
        var adet = Int(adetLabel.text!)!
        var toplam = fiyat * adet
        toplamTutarLabel.text = "Toplam Turar: \(toplam)₺"
    }
    func ekle(){
        if let yk = defaults.object(forKey: "username"){
            detayPresenterNesnesi?.yemekleriYukle(kullanici_adi: yk as! String)
        }
        let y = yemek
        let sayi = yemekListe.count
        var iterator = 0
        if yemekListe.isEmpty{
            if let yadet = adetLabel.text, let y = yemek, let ya = defaults.object(forKey: "username"){
                detayPresenterNesnesi?.ekle(yemek_adi: y.yemek_adi, yemek_resim_adi: y.yemek_resim_adi,yemek_fiyat:y.yemek_fiyat, yemek_siparis_adet: yadet, kullanici_adi: ya as! String)
            }
        }else{
            while iterator<sayi{
                let adet = Int(yemekListe[iterator].yemek_siparis_adet)!
                let yadet = Int(stepper.value)
                let toplamAdet = adet + yadet
                if yemekListe[iterator].yemek_adi == y?.yemek_adi {
                    detayPresenterNesnesi?.sil(sepet_yemek_id: yemekListe[iterator].sepet_yemek_id, kullanici_adi: yemekListe[iterator].kullanici_adi)
                    if let y = yemek, let ya = defaults.object(forKey: "username"){
                        detayPresenterNesnesi?.ekle(yemek_adi: y.yemek_adi, yemek_resim_adi: y.yemek_resim_adi,yemek_fiyat:y.yemek_fiyat, yemek_siparis_adet: "\(toplamAdet)", kullanici_adi: ya as! String)
                        break
                    }
                    
                    
                }else if iterator == sayi-1 && yemekListe[iterator].yemek_adi != y?.yemek_adi {
                    if let yadet = adetLabel.text, let y = yemek, let ya = defaults.object(forKey: "username"){
                        detayPresenterNesnesi?.ekle(yemek_adi: y.yemek_adi, yemek_resim_adi: y.yemek_resim_adi,yemek_fiyat:y.yemek_fiyat, yemek_siparis_adet: yadet, kullanici_adi: ya as! String)
                    }
                    
                }
                iterator += 1
            }
        }
        
    }
 }
 
 extension DetayVC: PresenterToViewDetayProtocol {
    func vieweVeriGonder(yemeklerListesi: Array<SepetYemekler>) {
        self.yemekListe = yemeklerListesi
    }
 }
