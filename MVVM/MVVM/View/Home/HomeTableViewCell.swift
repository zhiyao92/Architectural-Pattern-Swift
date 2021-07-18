//
//  HomeTableViewCell.swift
//  MVVM
//
//  Created by Kelvin Tan on 08/06/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    public func configureBucketList(_ bucketList: BucketList) {
        titleLabel.text = bucketList.name
        dateLabel.text = bucketList.date.formattedString
    }
}
