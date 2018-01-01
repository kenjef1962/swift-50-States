//
//  StatesTableViewController.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesTableViewController: UIViewController  {

    @IBOutlet weak var statesTableView: UITableView!

    fileprivate var states: [State]!
    fileprivate var imageType = Settings.listImageType
    
    static let identifier = "statesTableViewController"
}

// MARK: --
// MARK: Life Cycle Methods
extension StatesTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        states = DataManager.instance.getStateList()
        
        statesTableView.layer.borderColor = UIColor.lightGray.cgColor
        statesTableView.layer.borderWidth = 0.25
        statesTableView.layoutMargins = .zero
        statesTableView.separatorInset = .zero
        statesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if imageType != Settings.listImageType {
            imageType = Settings.listImageType
            statesTableView.reloadData()
        }
    }
}

// MARK: --
// MARK: Data Source Methods
extension StatesTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reusableCell = tableView.dequeueReusableCell(withIdentifier: StatesTableViewCell.cellIdentifier) else { fatalError() }
        guard let cell = reusableCell as? StatesTableViewCell else { fatalError() }
        
        cell.configure(imageType: imageType, state: states[indexPath.row])
        
        return cell
    }
}

// MARK: --
// MARK: Delegate Methods
extension StatesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: StatesDetailViewController.identifier) else { fatalError() }
        guard let detailVC = vc as? StatesDetailViewController else { fatalError() }
        
        detailVC.configure(state: states[indexPath.row])
        show(detailVC, sender: self)
    }
}


