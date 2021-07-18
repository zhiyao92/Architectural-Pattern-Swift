//
//  HomeInteractor.swift
//  VIPER
//
//  Created by Kelvin Tan on 28/06/2021.
//

import Foundation

protocol HomeInteractorToPresenterProtocol: class {
    func fetchBucketListSuccess()
    func fetchBucketListFail()
}

class HomeInteractor: HomePresenterToInteractorProtocol {
    var presenter: HomeInteractorToPresenterProtocol?

    var bucketLists: [BucketList]?

    func fetchBucketList() {
        self.bucketLists = []
        self.presenter?.fetchBucketListSuccess()
    }

    func addBucketList(_ bucketList: String?) {
        if let bucketListName = bucketList {
            let bucketList = BucketList(name: bucketListName, date: Date())
            bucketLists?.append(bucketList)
            self.presenter?.fetchBucketListSuccess()
        }
    }

    func updateBucketList(_ bucketList: BucketList) {
        if let bucketListIndex = self.bucketLists?.firstIndex(where: { $0.name == bucketList.name }) {
            bucketLists?[bucketListIndex] = bucketList
            self.presenter?.fetchBucketListSuccess()
        }
    }
}
