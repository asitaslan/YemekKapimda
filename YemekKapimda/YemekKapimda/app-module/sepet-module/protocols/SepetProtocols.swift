//
//  SepetProtocols.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 11.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation

protocol ViewToPresenterSepetProtocol {
    var sepetInteractor:PresenterToInteractorSepetProtocol? {get set}
    var sepetView:PresenterToViewSepetProtocol? {get set}
    
    func yemekleriYukle(kullaniciadi:String)
    func sil(sepet_yemek_id:String, kullanici_adi:String)
}

protocol PresenterToInteractorSepetProtocol {
    var sepetPresenter:InteractorToPresenterSepetProtocol? {get set}
    
    func tumYemekleriAl(kullaniciadi:String)
    func yemekSil(sepet_yemek_id:String, kullanici_adi:String)
}

protocol InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(yemeklerListesi:Array<SepetYemekler>)
}

protocol PresenterToViewSepetProtocol {
    func vieweVeriGonder(yemeklerListesi:Array<SepetYemekler>)
}

protocol PresenterToRouterSepetProtocol {
    static func createModule(ref:SepetVC)
}
