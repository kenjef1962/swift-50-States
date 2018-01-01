//
//  StatesCollectionViewController
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesCollectionViewController: UIViewController  {

    @IBOutlet weak var statesCollectionView: UICollectionView!
    
    fileprivate var states: [State]!
    fileprivate var imageType = Settings.gridImageType
    
    static let identifier = "statesCollectionViewController"
}

// MARK: --
// MARK: Life Cycle Methods
extension StatesCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        states = DataManager.instance.getStateList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if imageType != Settings.gridImageType {
            imageType = Settings.gridImageType
            statesCollectionView.reloadData()
        }
    }
}

// MARK: --
// MARK: Data Source Methods
extension StatesCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: StatesCollectionViewCell.cellIdentifier, for: indexPath)
        guard let cell = reusableCell as? StatesCollectionViewCell else { fatalError() }
        
        cell.configure(imageType: imageType, state: states[indexPath.row])
        
        return cell
    }
}

// MARK: --
// MARK: Delegate Methods
extension StatesCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: StatesDetailViewController.identifier) else { fatalError() }
        guard let detailVC = vc as? StatesDetailViewController else { fatalError() }

        detailVC.configure(state: states[indexPath.row])
        show(detailVC, sender: self)
    }
}

