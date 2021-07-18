//
//  HomeInteractor.swift
//  Clean Architecture
//
//  Created by Kelvin Tan on 14/07/2021.
//

import Foundation

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }

    func addBucketList(_ bucketListName: String?)
    func updateBucketList(_ bucketList: BucketList)
}

class HomeInteractor: HomeInteractorProtocol {

    private var bucketLists: [BucketList] = []

    var presenter: HomePresenterProtocol?

    func addBucketList(_ bucketListName: String?) {
        if let bucketListName = bucketListName {
            let bucketList = BucketList(name: bucketListName, date: Date())
            bucketLists.append(bucketList)
            presenter?.reloadView(bucketLists)
        }
    }

    func updateBucketList(_ bucketList: BucketList) {
        if let bucketListIndex = bucketLists.firstIndex(where: { $0.name == bucketList.name }) {
            bucketLists[bucketListIndex] = bucketList
            presenter?.reloadView(bucketLists)
        }
    }
}
