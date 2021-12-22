//
//  AnasayfaProtocols.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 10.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation

protocol ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView:PresenterToViewAnasayfaProtocol? {get set}
    func yemekleriYukle()
}
protocol PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    func tumYemekleriAl()
}
protocol InteractorToPresenterAnasayfaProtocol {
    func dataToPresenter(yemekListesi:Array<Yemekler>)
}
protocol PresenterToViewAnasayfaProtocol{
    func dataToView(yemeklerListesi:Array<Yemekler>)
}
protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:ViewController)
}
