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
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        applyGradient()
    }
    
    var places  = [Place]()
    var apiManager = APIManager.shared
    
    func applyGradient() {
        view.applyGradient([Colors.customGray, Colors.customDarkGray, .darkGray])
    }
    func populateCollectionView() {
        apiManager.retrievePlaceObjects { (objects) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.places = objects
            if self.places.count == 0 {
                self.displayAlert()
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func displayAlert() {
        let alert = UIAlertController(title: "No Internet", message: "Looks like you aren't connected to the internet at this time. Try again later!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func setupViews() {
        setupCollectionView()
        populateCollectionView()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.isPrefetchingEnabled = false
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
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCollectionViewCell.reuseID)
        return collectionView
    }()
}

extension PlaceCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PlaceDetailViewController()
        vc.place = places[indexPath.item]
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
        let item = places[indexPath.item]
        
        if let imageURLString: String = item.url, let imageURL = URL(string: imageURLString) {
            apiManager.requestImage(at: imageURL, completion: { (image) in
                if let image = image, let visibleCell = collectionView.cellForItem(at: indexPath) as? PlaceCollectionViewCell {
                    visibleCell.placeImageView.image = image
                }
            })
        }
        
        return cell
    }
}
