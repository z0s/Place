//
//  PlaceCollectionViewController.swift
//  Place
//
//  Created by Zubair on 6/1/17.
//  Copyright © 2017 Zubair. All rights reserved.
//

import UIKit

class PlaceCollectionViewController: UIViewController {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0)
        setupViews()
    }
    var places  = [Place]()
    var apiManager = APIManager.shared
    
    func populateCollectionView() {
        apiManager.retrievePlaceObjects { (objects) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.places = objects
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupViews() {
        setupCollectionView()
        populateCollectionView()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 239)
        layout.sectionInset = UIEdgeInsetsMake(15, 10, 0, 10)
        layout.minimumLineSpacing = 30
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCollectionViewCell.reuseID)
        return collectionView
    }()
}

extension PlaceCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PlaceDetailViewController()
        vc.place = places[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension PlaceCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.reuseID, for: indexPath)  as? PlaceCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = places[indexPath.row]
        
        if let imageURLString: String = item.url {
            if let imageURL = URL(string: imageURLString) {
                apiManager.requestImage(at: imageURL, completion: { (image) in
                    if let image = image {
                        cell.placeImageView.image = image
                    }
                })
            }
        }
        
        return cell
    }
}
