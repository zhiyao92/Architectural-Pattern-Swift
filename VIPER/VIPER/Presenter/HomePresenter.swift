//
//  HomePresenter.swift
//  VIPER
//
//  Created by Kelvin Tan on 28/06/2021.
//

import Foundation

protocol HomePresenterToInteractorProtocol {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    var bucketLists: [BucketList]? { get }

    func fetchBucketList()
    func addBucketList(_ bucketList: String?)
    func updateBucketList(_ bucketList: BucketList)
}

protocol HomePresenterToViewProtocol {
    func reloadView()
}

class HomePresenter: HomeViewToPresenterProtocol {

    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomeRouterProtocol?

    func updateView() {
        interactor?.fetchBucketList()
    }

    func addBucketList(_ bucketList: String?) {
        interactor?.addBucketList(bucketList)
    }

    func updateBucketList(_ bucketList: BucketList) {
        interactor?.updateBucketList(bucketList)
    }

    func getBucketListCount() -> Int? {
        return interactor?.bucketLists?.count
    }

    func getBucketList(_ index: Int) -> BucketList? {
        return interactor?.bucketLists?[index]
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func fetchBucketListSuccess() {
        view?.reloadView()
    }

    func fetchBucketListFail() {
        view?.reloadView()
    }
}
