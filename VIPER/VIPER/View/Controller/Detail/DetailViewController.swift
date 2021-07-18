//
//  DetailViewController.swift
//  MVC
//
//  Created by Kelvin Tan on 03/06/2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var completeButton: UIButton!
    @IBOutlet private weak var giveUpButton: UIButton!

    private var bucketList: BucketList

    var updateBucketList: ((_ bucketList: BucketList) -> Void)?

    init(bucketList: BucketList) {
        self.bucketList = bucketList
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        self.title = "Detail"

        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = bucketList.name

        dateLabel.font = UIFont.systemFont(ofSize: 20)
        dateLabel.textAlignment = .center
        dateLabel.textColor = .lightGray
        dateLabel.text = "Added on \(bucketList.date.formattedString ?? "--")"

        completeButton.setTitle("Complete 👍", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.backgroundColor = .green
        completeButton.layer.cornerRadius = 16

        giveUpButton.setTitle("Give up 👎", for: .normal)
        giveUpButton.setTitleColor(.white, for: .normal)
        giveUpButton.backgroundColor = .red
        giveUpButton.layer.cornerRadius = 16
    }

    @IBAction func tapCompleteButton() {
        bucketList.completed = true
        bucketList.givenUp = false
        updateBucketList?(bucketList)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tapGiveUpButton() {
        bucketList.completed = false
        bucketList.givenUp = true
        updateBucketList?(bucketList)
        self.navigationController?.popViewController(animated: true)
    }
}

