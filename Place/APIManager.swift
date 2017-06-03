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
            
            
            //            func displayError(_ error: String) {
            //                print(error)
            //                print("URL at time of error: \(url)")
            //            }
            //
            guard error == nil else {
                self.displayError("There was an error with your request: \(String(describing: error))", url: url)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                self.displayError("Your request returned a status code other than 2xx!", url: url)
                return
            }
            
            guard let data = data else {
                self.displayError("No data was returned by the request!", url: url)
                return
            }
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                self.displayError("Could not parae the data as JSON: '\(data)'", url: url)
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
        var request = URLRequest(url: imageURL)
        request.cachePolicy = .returnCacheDataElseLoad
        let imageDownloadTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var image: UIImage? = nil
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                self.displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            if let imageData = data {
                image = UIImage(data: imageData)
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        imageDownloadTask.resume()
    }
    
    func displayError(_ error: String, url: URL? = nil) {
        print(error)
        print("URL at time of error: \(String(describing: url))")
    }
}

