//
//  StatesDetailViewController.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesDetailViewController: UIViewController {

    @IBOutlet weak var stateHeaderView: UIView!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var stateNicknameLabel: UILabel!
    @IBOutlet weak var stateCapitalLabel: UILabel!
    @IBOutlet weak var stateLargestCityLabel: UILabel!

    @IBOutlet weak var infoTableView: UITableView!
    
    var state: State!
    
    static let identifier = "statesDetailViewController"
    
    func configure(state: State)
    {
        self.state = state
    }
}

// MARK: --
// MARK: Life Cycle Methods
extension StatesDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = state.name
        
        stateHeaderView.roundCorners()
        stateNameLabel.text = state.name
        stateNameLabel.roundCorners(radius: 5)
        stateNicknameLabel.text = state.nickname
        stateCapitalLabel.text = state.capitalCity
        stateLargestCityLabel.text = state.largestCity
        
        infoTableView.layer.borderColor = UIColor.lightGray.cgColor
        infoTableView.layer.borderWidth = 0.25
        infoTableView.layoutMargins = .zero
        infoTableView.separatorInset = .zero
        infoTableView.tableFooterView = UIView()
    }
}

// MARK: --
// MARK: Data Source Methods
extension StatesDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reusableCell = infoTableView.dequeueReusableCell(withIdentifier: StatesDetailViewCell.cellIdentifier) else { fatalError() }
        guard let cell = reusableCell as? StatesDetailViewCell else { fatalError() }
        
        cell.configure(state: state, infoItem: state.items[indexPath.row] )
        
        return cell
    }
}

// MARK: --
// MARK: Delegate Methods
extension StatesDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { fatalError() }
        guard cell.accessoryType == .disclosureIndicator else { return }

        let infoItem = state.items[indexPath.row]

        guard let vc = storyboard?.instantiateViewController(withIdentifier: ImageDetailViewController.identifier) else { fatalError() }
        guard let detailVC = vc as? ImageDetailViewController else { fatalError() }

        let bounds = view.frame.size
        let width = bounds.width * 0.75
        let height = bounds.height * 0.75
        let cxy = width <= height ? width : height

        detailVC.configure(state, infoItem: infoItem)
        detailVC.preferredContentSize = CGSize(width: cxy, height: cxy)
        detailVC.modalPresentationStyle = UIDevice.current.userInterfaceIdiom == .phone ? .fullScreen : .formSheet

        self.present(detailVC, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let infoItem = state.items[indexPath.row]
        let title = "State \(infoItem.type.stringValue) of \(state.name)"

        var message = infoItem.value ?? ""
        message += !message.isEmpty ? "\n\n" : ""
        message += infoItem.description ?? ""

        UIAlertController.showBasicAlert(title, message: message, viewController: self, completion: nil)
    }
}
