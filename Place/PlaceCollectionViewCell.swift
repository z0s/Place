//
//  PlaceCollectionViewCell.swift
//  Place
//
//  Created by Zubair on 6/1/17.
//  Copyright © 2017 Zubair. All rights reserved.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {
    static let reuseID = "PlaceCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0)
        setupSubview()
    }
    
    func setupSubview() {
        setUpPlaceImage()
        
    }
    //Place Image
    func setUpPlaceImage() {
        contentView.addSubview(placeImageView)
        //Place ImageView constraints
        placeImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        placeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        placeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        placeImageView.image = #imageLiteral(resourceName: "missing-image")
        
    }

    lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

