//
//  PlaceDetailViewController.swift
//  Place
//
//  Created by Zubair on 6/2/17.
//  Copyright © 2017 Zubair. All rights reserved.
//

import UIKit

class PlaceDetailViewController: UIViewController {
    var place: Place?
    let apiManager = APIManager.shared
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = Colors.customDarkGray
        setupSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        applyGradient()
    }
    func applyGradient() {
//        view.applyGradient([Colors.customGray, Colors.customDarkGray, .darkGray])
    }

    func setupSubviews() {
        setUpPlaceImage()
        setUpPlaceTitle()
        setUpPlaceHours()
        setUpPlaceDescription()
    }
    
    func setUpPlaceImage() {
        view.addSubview(placeImageView)
        
        placeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive = true
        placeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        placeImageView.heightAnchor.constraint(equalToConstant: 677/2.66).isActive = true
        placeImageView.widthAnchor.constraint(equalToConstant: 850/2.66).isActive = true
        
        if let imageURLString: String = place?.url {
            if let imageURL = URL(string: imageURLString) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                apiManager.requestImage(at: imageURL, completion: { (image) in
                    if let image = image {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self.placeImageView.image = image
                    }
                })
            }
        }
    }
    //Place Name
    func setUpPlaceTitle() {
//        view.addSubview(placeTitle)
        title = place?.title
        
    }
    //Place Hours of Operation
    func setUpPlaceHours() {
        view.addSubview(placeHours)
        placeHours.text = "Open " + (place?.hours)!
        placeHours.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 30).isActive = true
        placeHours.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        placeHours.sizeToFit()
        
    }
    //Place ID
    func setUpPlaceID() {
        
    }
    //Place Description
    func setUpPlaceDescription() {
        view.addSubview(placeDescription)
        placeDescription.text = place?.description
        placeDescription.topAnchor.constraint(equalTo: placeHours.bottomAnchor, constant: 30).isActive = true
        placeDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        placeDescription.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        placeDescription.sizeToFit()
    }
    
    lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var placeHours: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var placeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
}
