//
//  HomeViewController.swift
//  MVVM
//
//  Created by Kelvin Tan on 02/06/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
    }

    private func configureView() {
        self.title = "Bucket List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBucketList))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func configureViewModel() {
        viewModel = HomeViewModel(bucketLists: [])

        viewModel.bucketLists
            .bind { [weak self] (_) in
                guard let strongSelf = self else { return }
                strongSelf.tableView.reloadData()
            }
    }

    @objc func addBucketList() {
        let alert = UIAlertController(title: "Add Bucket List", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Go sky diving in Hawaii"
        }

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.addBucketList(alert.textFields?.first?.text)
        })
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bucketLists.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell?.selectionStyle = .none

        let bucketList = viewModel.bucketLists.value[indexPath.row]
        cell?.textLabel?.attributedText = viewModel.handleBucketList(bucketList)
        cell?.detailTextLabel?.text = bucketList.date.formattedString
        return cell!
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bucketList = viewModel.bucketLists.value[indexPath.row]
        let detailVC = DetailViewController(bucketList: bucketList)
        detailVC.updateBucketList = viewModel.updateBucketList
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
