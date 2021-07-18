//
//  HomeTableViewCell.swift
//  MVC
//
//  Created by Kelvin Tan on 08/06/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    public func configureBucketList(_ bucketList: BucketList) {
        titleLabel.attributedText = handleBucketListAttribute(bucketList)
        dateLabel.text = bucketList.date.formattedString
    }

    private func handleBucketListAttribute(_ bucketList: BucketList) -> NSAttributedString {
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
