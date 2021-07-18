//
//  HomeRouter.swift
//  VIPER
//
//  Created by Kelvin Tan on 28/06/2021.
//

import UIKit

protocol HomeRouterProtocol: class {
    static func createModule() -> UIViewController
}

class HomeRouter: HomeRouterProtocol {
    static func createModule() -> UIViewController {
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
}
