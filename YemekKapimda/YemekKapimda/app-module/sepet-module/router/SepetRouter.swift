//
//  SepetRouter.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 11.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation

class SepetRouter: PresenterToRouterSepetProtocol {
    static func createModule(ref: SepetVC) {
        let presenter : ViewToPresenterSepetProtocol & InteractorToPresenterSepetProtocol = SepetPresenter()
        
        ref.sepetPresenterNesnesi = presenter
        ref.sepetPresenterNesnesi?.sepetInteractor = SepetInteractor()
        ref.sepetPresenterNesnesi?.sepetView = ref 
        ref.sepetPresenterNesnesi?.sepetInteractor?.sepetPresenter = presenter
    }
}
