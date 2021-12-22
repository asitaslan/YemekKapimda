//
//  DetayPresenter.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 8.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
class DetayPresenter: ViewToPresenterDetayProtocol {
    var yemekDetayInteractor: PresenterToInteractorDetayProtocol?
    var detayView: PresenterToViewDetayProtocol?
    
    func yemekleriYukle(kullanici_adi: String) {
        yemekDetayInteractor?.tumYemekleriAl(kullanici_adi: kullanici_adi)
    }
    
    func sil(sepet_yemek_id: String, kullanici_adi: String) {
        yemekDetayInteractor?.yemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    func ekle(yemek_adi: String, yemek_resim_adi: String,yemek_fiyat:String, yemek_siparis_adet: String, kullanici_adi: String) {
        yemekDetayInteractor?.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat:yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
}
extension DetayPresenter: InteractorToPresenterDetayProtocol{
    func presenteraVeriGonder(yemeklerListesi: Array<SepetYemekler>) {
        detayView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
