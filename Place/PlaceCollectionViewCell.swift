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
//        Place ImageView constraints
        placeImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        placeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        placeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        placeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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
/*
 

 
 lazy var detailView: UIView = {
 let v = UIView()
 v.frame = CGRect.zero
 v.backgroundColor = .white
 return v
 }()
 
 lazy var heartView: UIImageView = {
 let view = UIImageView()
 view.image = UIImage(named: "heart-filled")?.withRenderingMode(.alwaysTemplate)
 view.tintColor = .white
 return view
 }()
 
 lazy var fillMaskView: UIView = {
 let view = UIView()
 view.backgroundColor = .magma
 view.alpha = 0.5
 return view
 }()
 
 lazy var titleLabel: UILabel = {
 let myLabel = UILabel()
 myLabel.text = "Element Title"
 myLabel.font = UIFont.detailSemiBold()
 myLabel.textColor = .richDark
 myLabel.textAlignment = .center
 myLabel.frame = CGRect.zero
 return myLabel
 }()
 
 lazy var subtitleLabel: UILabel = {
 let myLabel = UILabel()
 myLabel.text = "2017"
 myLabel.font = UIFont.detail()
 myLabel.textColor = .mediumGray
 myLabel.frame = CGRect.zero
 return myLabel
 }()
 
 lazy var circularView: UIView = {
 let view = UIView()
 view.backgroundColor = .white
 return view
 }()
 
 lazy var typeImageView: UIImageView = {
 let imageView = UIImageView()
 return imageView
 }()
 
 lazy var onboardingImageView: UIImageView = {
 let myContentImageView = UIImageView()
 myContentImageView.frame = CGRect.zero
 myContentImageView.contentMode = .scaleAspectFill
 myContentImageView.clipsToBounds = true
 myContentImageView.backgroundColor = .clear
 myContentImageView.tintColor = .white
 
 return myContentImageView
 }()
 
 lazy var missingImageBackground: UIView = {
 let view = UIView()
 view.backgroundColor = .magma
 return view
 }()
 
 lazy var missingImage: UIImageView = {
 let view = UIImageView()
 view.image = UIImage(named: "missing-image-light")?.withRenderingMode(.alwaysTemplate)
 view.tintColor = .white
 return view
 }()
 }

 
 */
