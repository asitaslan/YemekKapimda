//
//  SepetInteractor.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 11.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
import Alamofire
class SepetInteractor: PresenterToInteractorSepetProtocol {
    var sepetPresenter: InteractorToPresenterSepetProtocol?
    func tumYemekleriAl(kullaniciadi:String) {
        let params : Parameters = ["kullanici_adi":kullaniciadi]
        Alamofire.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).responseJSON{ response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    var liste = [SepetYemekler]()
                    if let gelenListe = cevap.sepet_yemekler {
                        liste = gelenListe
                    }
                    self.sepetPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                }catch let error{
                    print(error.localizedDescription)
                    self.sepetPresenter?.presenteraVeriGonder(yemeklerListesi: [])
                }
            }
        }
    }
    
    func yemekSil(sepet_yemek_id: String, kullanici_adi: String) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id, "kullanici_adi":kullanici_adi]
        Alamofire.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post,parameters: params).responseJSON { response in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        self.tumYemekleriAl(kullaniciadi: kullanici_adi)
                        
                }
                }catch let error{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
