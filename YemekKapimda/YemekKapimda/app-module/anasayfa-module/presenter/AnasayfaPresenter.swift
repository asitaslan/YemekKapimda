//
//  AnasayfaPresenter.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 10.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
class AnasayfaPresenter: ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yemekleriYukle() {
        anasayfaInteractor?.tumYemekleriAl()
    }
}
extension AnasayfaPresenter: InteractorToPresenterAnasayfaProtocol {
    func dataToPresenter(yemekListesi: Array<Yemekler>) {
        anasayfaView?.dataToView(yemeklerListesi: yemekListesi)
    }
    
    
}
