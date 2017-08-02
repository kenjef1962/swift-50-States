//
//  StatesCollectionViewController
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var statesCollectionView: UICollectionView!
    
    fileprivate var states: [State]!
    fileprivate var defaultImageType = StateImageType.flag

    override func viewDidLoad() {
        super.viewDidLoad()
        
        statesCollectionView.dataSource = self
        statesCollectionView.delegate = self
        
        states = DataManager.instance.getStateList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if defaultImageType != Utils.defaultImageType {
            statesCollectionView.reloadData()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        defaultImageType = Utils.defaultImageType
    }
    
    // MARK: --
    // MARK: Data Source Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let state = states[(indexPath as NSIndexPath).row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statesCell", for: indexPath) as? StatesCollectionViewCell {
            cell.setup(Utils.defaultImageType, state: state)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: --
    // MARK: Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let state = states[(indexPath as NSIndexPath).row]
        
        if let stateDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "statesDetailViewController") as? StatesDetailViewController {
            stateDetailVC.setup(state)
            
            navigationController?.pushViewController(stateDetailVC, animated: true)
        }
    }
}

