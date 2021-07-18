//
//  HomeViewController.swift
//  MVC
//
//  Created by Kelvin Tan on 02/06/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var bucketLists: [BucketList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        self.title = "Bucket List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }

    @objc func addToDo() {
        let alert = UIAlertController(title: "Add Bucket List", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Go sky diving in Hawaii"
        }

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            guard let strongSelf = self else { return }
            if let enteredBucketList = alert.textFields?.first?.text {
                let bucketList = BucketList(name: enteredBucketList, date: Date())
                strongSelf.bucketLists.append(bucketList)
                strongSelf.tableView.reloadData()
            }
        })
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func updateBucketList(_ bucketList: BucketList) {
        if let bucketListIndex = bucketLists.firstIndex(where: { $0.name == bucketList.name }) {
            bucketLists[bucketListIndex] = bucketList
            tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketLists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { fatalError("HomeTableViewCell not found") }
        cell.selectionStyle = .none

        let bucketList = bucketLists[indexPath.row]
        cell.configureBucketList(bucketList)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bucketList = bucketLists[indexPath.row]
        let detailVC = DetailViewController(bucketList: bucketList)
        detailVC.updateBucketList = updateBucketList
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

