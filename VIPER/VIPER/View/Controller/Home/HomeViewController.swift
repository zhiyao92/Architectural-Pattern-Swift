//
//  HomeViewController.swift
//  MVC
//
//  Created by Kelvin Tan on 02/06/2021.
//

import UIKit

protocol HomeViewToPresenterProtocol {
    var view: HomePresenterToViewProtocol? { get set }
    var interactor: HomePresenterToInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }

    func updateView()
    func addBucketList(_ bucketList: String?)
    func updateBucketList(_ bucketList: BucketList)
    func getBucketListCount() -> Int?
    func getBucketList(_ index: Int) -> BucketList?
}

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: HomeViewToPresenterProtocol?

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

        presenter?.updateView()
    }

    @objc func addToDo() {
        let alert = UIAlertController(title: "Add Bucket List", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Go sky diving in Hawaii"
        }

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.addBucketList(alert.textFields?.first?.text)
        })
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func updateBucketList(_ bucketList: BucketList) {
        presenter?.updateBucketList(bucketList)
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getBucketListCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { fatalError("HomeTableViewCell not found") }
        cell.selectionStyle = .none

        let bucketList = presenter?.getBucketList(indexPath.row)
        cell.configureBucketList(bucketList)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let bucketList = presenter?.getBucketList(indexPath.row) {
            let detailVC = DetailViewController(bucketList: bucketList)
            detailVC.updateBucketList = updateBucketList
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension HomeViewController: HomePresenterToViewProtocol {
    func reloadView() {
        tableView.reloadData()
    }
}
