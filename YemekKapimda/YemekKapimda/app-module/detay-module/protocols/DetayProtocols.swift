//
//  DetayProtocols.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 8.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation

protocol ViewToPresenterDetayProtocol {
    var yemekDetayInteractor : PresenterToInteractorDetayProtocol? {get set}
    var detayView:PresenterToViewDetayProtocol? {get set}
    func ekle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:String,yemek_siparis_adet:String, kullanici_adi:String)
    func yemekleriYukle(kullanici_adi:String)
    func sil(sepet_yemek_id:String, kullanici_adi:String)
    
}
protocol PresenterToInteractorDetayProtocol {
    var detayPresenter:InteractorToPresenterDetayProtocol? {get set}
    
    func sepeteEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:String,yemek_siparis_adet:String, kullanici_adi:String)
    func tumYemekleriAl(kullanici_adi:String)
    func yemekSil(sepet_yemek_id:String, kullanici_adi:String)
}
protocol InteractorToPresenterDetayProtocol {
    func presenteraVeriGonder(yemeklerListesi:Array<SepetYemekler>)
}
protocol PresenterToViewDetayProtocol {
    func vieweVeriGonder(yemeklerListesi:Array<SepetYemekler>)
}
protocol PresenterToRouterDetayProtocol {
    static func createModule(ref:DetayVC)
}
