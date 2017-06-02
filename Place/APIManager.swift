//
//  APIManager.swift
//  Place
//
//  Created by Zubair on 6/1/17.
//  Copyright © 2017 Zubair. All rights reserved.
//

import UIKit

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func retrievePlaceObjects(completionHandler: @escaping ([Place]) -> ()) {
        var placeResults = [Place]()
        let urlString =  "https://fetchy-interview.herokuapp.com/api/placedata"
        let session = URLSession.shared
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let url = URL(string: urlString) else {
            return print("url is returning an error.")
            
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func displayError(_ error: String) {
                print(error)
                print("URL at time of error: \(url)")
            }
            
            guard error == nil else {
                displayError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                displayError("Could not parae the data as JSON: '\(data)'")
                return
            }
            
            let placeArray = parsedResult["data"] as! [[String:AnyObject]]
            
            for place in placeArray {
                placeResults.append(Place(place))
            }
            
            DispatchQueue.main.async {
                completionHandler(placeResults)
            }
        }
        task.resume()
    }
    
    func requestImage(at imageURL: URL, completion: @escaping ((UIImage?) -> Void)) {
        let imageDownloadTask = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
            var image: UIImage? = nil
            func displayError(_ error: String) {
                print(error)
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            if let imageData = data {
                image = UIImage(data: imageData)
            }
            DispatchQueue.main.async {
                completion(image)
            }
        })
        imageDownloadTask.resume()
    }
}

