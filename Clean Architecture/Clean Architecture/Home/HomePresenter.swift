//
//  HomePresenter.swift
//  Clean Architecture
//
//  Created by Kelvin Tan on 14/07/2021.
//

import Foundation

protocol HomePresenterProtocol {
    var viewController: HomeViewProtocol? { get set }
    
    func reloadView(_ bucketLists: [BucketList])
}

class HomePresenter: HomePresenterProtocol {

    var viewController: HomeViewProtocol?

    func reloadView(_ bucketLists: [BucketList]) {
        viewController?.reloadView(bucketLists)
    }
}
