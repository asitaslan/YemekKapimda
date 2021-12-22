//
//  AnasayfaInteractor.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 10.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
import Alamofire

class AnasayfaInteractor: PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    func tumYemekleriAl() {
        Alamofire.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).responseJSON{ response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    var liste = [Yemekler]()
                    if let gelenListe = cevap.yemekler{
                        liste = gelenListe
                    }
                    self.anasayfaPresenter?.dataToPresenter(yemekListesi: liste)
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
}
