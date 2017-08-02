//
//  StatesTableViewController.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var statesTableView: UITableView!


    fileprivate var states: [State]!
    fileprivate var defaultImageType = StateImageType.flag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statesTableView.dataSource = self
        statesTableView.delegate = self
        
        states = DataManager.instance.getStateList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if defaultImageType != Utils.defaultImageType {
            statesTableView.reloadData()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        defaultImageType = Utils.defaultImageType
    }
    
    // MARK: --
    // MARK: Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = states[(indexPath as NSIndexPath).row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: "statesCell") as? StatesTableViewCell {
            cell.setup(Utils.defaultImageType, state: state)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: --
    // MARK: Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = states[(indexPath as NSIndexPath).row]
        
        if let stateDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "statesDetailViewController") as? StatesDetailViewController {
            stateDetailVC.setup(state)
            
            navigationController?.pushViewController(stateDetailVC, animated: true)
        }
    }
}


