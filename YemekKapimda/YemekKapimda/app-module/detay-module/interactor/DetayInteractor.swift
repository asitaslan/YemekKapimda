//
//  DetayInteractor.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 8.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
import Alamofire
class DetayInteractor: PresenterToInteractorDetayProtocol {
    var detayPresenter: InteractorToPresenterDetayProtocol?
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String,yemek_fiyat:String, yemek_siparis_adet: String, kullanici_adi: String) {
        let params:Parameters = ["yemek_adi":yemek_adi,
                                 "yemek_resim_adi":yemek_resim_adi,
                                 "yemek_fiyat":yemek_fiyat,
                                 "yemek_siparis_adet":yemek_siparis_adet,
                                 "kullanici_adi":kullanici_adi]
        
        Alamofire.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post,parameters: params).responseJSON{ response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    func tumYemekleriAl(kullanici_adi:String) {
           let params : Parameters = ["kullanici_adi":kullanici_adi]
           Alamofire.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).responseJSON{ response in
               if let data = response.data {
                   do {
                       let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                       var liste = [SepetYemekler]()
                       if let gelenListe = cevap.sepet_yemekler {
                           liste = gelenListe
                       }
                       self.detayPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                   }catch {
                       self.detayPresenter?.presenteraVeriGonder(yemeklerListesi: [])
                       
                   }
               }
           }
       }
       
       func yemekSil(sepet_yemek_id: String, kullanici_adi: String) {
           let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,
                                    "kullanici_adi":kullanici_adi]
           Alamofire.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post,parameters: params).responseJSON { response in
               if let data = response.data {
                   do {
                       if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                           print(json)
                           self.tumYemekleriAl(kullanici_adi: kullanici_adi)
                           
                   }
                   }catch{
                       
                   }
               }
           }
           
       }
    
}
