//
//  DetayRouter.swift
//  YemekKapimda
//
//  Created by Asit Aslan on 8.12.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
class DetayRouter: PresenterToRouterDetayProtocol{
    static func createModule(ref: DetayVC) {
        let presenter : ViewToPresenterDetayProtocol & InteractorToPresenterDetayProtocol = DetayPresenter()
        ref.detayPresenterNesnesi = presenter
        ref.detayPresenterNesnesi?.yemekDetayInteractor = DetayInteractor()
        ref.detayPresenterNesnesi?.detayView = ref
        ref.detayPresenterNesnesi?.yemekDetayInteractor?.detayPresenter = presenter
    }
}
