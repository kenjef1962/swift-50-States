//
//  DataManager.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireImage
import SwiftyJSON

class DataManager {

    static let instance = DataManager()
    
    fileprivate var imageCache: [String: UIImage] = [:]
    fileprivate var states = [State]()
    
    func getStateList() -> [State] {
        guard 0 == states.count else { return states }
        
        guard let file = Bundle.main.path(forResource: "StatesInfo", ofType: "JSON") else { return states }
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: file)) else { return states }
        
        guard let json = try? JSON(data: jsonData) else { return states }

        for (_, value) in json["States"] {
            if let state = State(json: value) {
                states.append(state)
            }
        }
        
        return states
    }
    
    fileprivate func getImagePath(state: State, imageType: ImageType, imageSize: ImageSize) -> String? {
        var imagePath = "http://www.50states.com/images/redesign/\(imageType.stringValue)s/"
        
        switch imageType {
        case .quarter:
            imagePath += "\(state.name)_\(imageSize.stringValue)_\(imageType.stringValue).png"
            break
        default:
            imagePath += "\(state.abbreviation)-\(imageSize.stringValue)\(imageType.stringValue).png"
            break
        }
        
        return imagePath.replacingOccurrences(of: " ", with: "_").lowercased()
    }
    
    func getImage(state: State, imageType: ImageType, imageSize: ImageSize, completion: @escaping (UIImage?) -> Void) {
        guard imageType != .none else { return completion(nil) }
        
        let cacheKey = "\(state.abbreviation).\(imageType.stringValue).\(imageSize.stringValue)"
        
        if let image = imageCache[cacheKey] {
            return completion(image)
        }
        
        guard let imagePath = getImagePath(state: state, imageType: imageType, imageSize: imageSize) else { return completion(nil) }
        guard let imageURL = URL(string: imagePath) else { return completion(nil) }
        
        Alamofire.request(imageURL, method: .get).responseImage { response in
            guard let image = response.result.value else { return completion(nil) }
            
            self.imageCache[cacheKey] = image
            return completion(image)
        }
    }
}
