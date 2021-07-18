//
//  HomeViewModel.swift
//  MVVM
//
//  Created by Kelvin Tan on 04/06/2021.
//

import UIKit

class HomeViewModel: NSObject {

    var bucketLists: Box<[BucketList]> = Box([])

    init(bucketLists: [BucketList]) {
        self.bucketLists.value = bucketLists
    }

    func addBucketList(_ textField: String?) {
        if let bucketListName = textField {
            let bucketList = BucketList(name: bucketListName, date: Date())
            bucketLists.value.append(bucketList)
        }
    }

    func updateBucketList(_ bucketList: BucketList) {
        if let bucketListIndex = bucketLists.value.firstIndex(where: { $0.name == bucketList.name }) {
            bucketLists.value[bucketListIndex] = bucketList
        }
    }

    func handleBucketList(_ bucketList: BucketList) -> NSAttributedString {
        var strokeEffect: [NSAttributedString.Key : Any] = [:]
        var bucketListName = bucketList.name

        if bucketList.completed {
            strokeEffect = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                            NSAttributedString.Key.strikethroughColor: UIColor.red]
        }

        if bucketList.givenUp {
            bucketListName = "You've given up on - \(bucketList.name)"
        }

        return NSAttributedString(string: bucketListName, attributes: strokeEffect)
    }
}
