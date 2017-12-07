//
//  ViewController.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 22.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit
import Services
import UIComponents

final class CarListViewController: BundleViewController {
    
    /// Reference to presenter
    var output: CarListViewOutput!
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Stores currently displaying objects count for making table animations good
    private var objectsCount: Int = 0
    
    /// For maintainig second section which shows loading indicator
    private var showsLoader: Bool = true
    
    /// Last received error message from presenter (to display in table cell)
    private var displayError: Error?
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonDidClick(_:)))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = rightBarButtonItem
        title = UIDateChooseController.Result.empty.formatted
    }
    
    @IBAction func searchButtonDidClick(_ sender: UIBarButtonItem) {
        let alert = UIDateChooseController(startDate: nil, endDate: nil) { [weak self] result in
            self?.output.set(startDate: result.startDate, endDate: result.endDate)
            self?.title = result.formatted
            self?.output.reload()
        }
        present(alert, animated: true, completion: nil)
    }
}

extension CarListViewController: CarListViewInput {
    
    func on(reload objects: [FLTCar]) {
        displayError = nil
        objectsCount = objects.count
        showsLoader = output.hasMore
        tableView.reloadData()
    }
    
    func on(append objects: [FLTCar]) {
        let indices = (objectsCount ..< (objectsCount + objects.count)).map { IndexPath(row: $0, section: 0) }
        tableView.beginUpdates()
        tableView.insertRows(at: indices, with: .automatic)
        if showsLoader && !output.hasMore {
            showsLoader = false
            tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
        }
        tableView.endUpdates()
        objectsCount = output.cars.count
    }
    
    func on(error: Error) {
        displayError = error
        tableView.reloadData()
    }
}

extension CarListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? output.cars.count : (showsLoader ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeue(with: CarTableViewCell.self)
            cell.car = output.cars[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeue(with: LoadingTableViewCell.self)
            cell.error = displayError
            return cell
        }
    }
}

extension CarListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1, displayError != nil {
            displayError = nil
            (tableView.cellForRow(at: indexPath) as? LoadingTableViewCell)?.error = nil
            output.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1, displayError == nil {
            output.loadMore()
        }
    }
}
