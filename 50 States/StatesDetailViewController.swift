//
//  StatesDetailViewController.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var stateInfoTableView: UITableView!
    
    var state: State!
    var symbols: [StateImageType] = [.flag, .seal, .quarter]
    
    func setup(_ state: State)
    {
        self.state = state
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = state.name
        stateInfoTableView.dataSource = self
        stateInfoTableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "State Info" : "State Symbols"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 2 : state.symbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") else { return UITableViewCell() }
        
        if ((indexPath as NSIndexPath).section == 0) {
            if indexPath.row == 0 {
                cell.textLabel!.text = "\(state.name) (\(state.abbreviation))"
                cell.detailTextLabel!.text = state.nickname

                cell.imageView!.contentMode = .center
                cell.imageView!.image = UIImage(named: "loading")
                
                state.getImage(StateImageType.map, imageSize: .small) { image in
                    cell.imageView!.image = image
                }
            }
            else {
                cell.textLabel!.text = "Admitted to the Union"
                cell.detailTextLabel!.text = "\(state.admissionDate) (\(state.admissionOrder))"
            }
        }
        else {
            let symbol = state.symbols[(indexPath as NSIndexPath).row]
            
            if indexPath.row < 3 {
                cell.accessoryType = .disclosureIndicator
                cell.imageView!.contentMode = .center
                cell.imageView!.image = UIImage(named: "loading")
                
                state.getImage(symbols[indexPath.row], imageSize: .small) { image in
                    cell.imageView!.image = image
                }
            }
            else if (symbol.description != nil) {
                cell.accessoryType = .detailButton
            }

            cell.textLabel!.text = symbol.type
            cell.detailTextLabel!.text = symbol.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ((indexPath as NSIndexPath).section != 0) {
            showDetails(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if ((indexPath as NSIndexPath).section != 0) {
            showDetails(at: indexPath)
        }
    }
    
    func showDetails(at indexPath: IndexPath) {
        let symbol = state.symbols[indexPath.row]
        
        if indexPath.row < 3 {
            if let imageDetailVC = storyboard?.instantiateViewController(withIdentifier: "imageDetailViewController") as? ImageDetailViewController {
                let bounds = view.frame.size
                let width = bounds.width * 0.75
                let height = bounds.height * 0.75
                let cxy = width <= height ? width : height
                
                imageDetailVC.setup(state, symbolType: symbol.type)
                imageDetailVC.preferredContentSize = CGSize(width: cxy, height: cxy)
                imageDetailVC.modalPresentationStyle = UIModalPresentationStyle.formSheet
                
                self.show(imageDetailVC, sender: self)
            }
        }
        else {
            let title = "State \(symbol.type) of \(state.name)"
            
            var message = symbol.name ?? ""
            if (message != "") {
                message += "\n\n"
            }
            message += symbol.description ?? ""
            
            Utils.showBasicAlert(title, message: message, viewController: self, completion: nil)
        }
    }
}
