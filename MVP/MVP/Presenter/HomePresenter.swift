//
//  HomePresenter.swift
//  MVP
//
//  Created by Kelvin Tan on 21/06/2021.
//

import Foundation

protocol HomePresenterViewProtocol: class {
    func reloadView(_ bucketLists: [BucketList])
}

class HomePresenter {

    weak var view: HomePresenterViewProtocol?
    private var bucketLists: [BucketList] = []

    init(with view: HomePresenterViewProtocol) {
        self.view = view
    }

    func addBucketList(_ bucketList: String?) {
        if let bucketListName = bucketList {
            let bucketList = BucketList(name: bucketListName, date: Date())
            bucketLists.append(bucketList)
            view?.reloadView(bucketLists)
        }
    }

    func updateBucketList(_ bucketList: BucketList) {
        if let bucketListIndex = bucketLists.firstIndex(where: { $0.name == bucketList.name }) {
            bucketLists[bucketListIndex] = bucketList
            view?.reloadView(bucketLists)
        }
    }
}
