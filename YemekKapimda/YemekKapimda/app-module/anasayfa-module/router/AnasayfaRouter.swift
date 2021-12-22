//
//  AnasayfaRouter.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 10.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation

class AnasayfaRouter: PresenterToRouterAnasayfaProtocol {
    static func createModule(ref: ViewController) {
        let presenter: ViewToPresenterAnasayfaProtocol & InteractorToPresenterAnasayfaProtocol = AnasayfaPresenter()
        
        ref.anasayfaPresenterNesnesi = presenter
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor = AnasayfaInteractor()
        ref.anasayfaPresenterNesnesi?.anasayfaView = ref
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor?.anasayfaPresenter = presenter
    }
    
    
}
