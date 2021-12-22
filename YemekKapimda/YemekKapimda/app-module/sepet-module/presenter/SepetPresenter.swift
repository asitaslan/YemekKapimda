//
//  SepetPresenter.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 11.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation

class SepetPresenter: ViewToPresenterSepetProtocol{
    var sepetInteractor: PresenterToInteractorSepetProtocol?
    
    var sepetView: PresenterToViewSepetProtocol?
    
    func yemekleriYukle(kullaniciadi:String) {
        sepetInteractor?.tumYemekleriAl(kullaniciadi:kullaniciadi)
    }
    
    func sil(sepet_yemek_id: String, kullanici_adi: String) {
        sepetInteractor?.yemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    

}
extension SepetPresenter: InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(yemeklerListesi: Array<SepetYemekler>) {
        sepetView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
