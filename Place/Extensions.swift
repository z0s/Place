//
//  Extensions.swift
//  Place
//
//  Created by Zubair on 6/2/17.
//  Copyright © 2017 Zubair. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradient(_ colors: [UIColor]) -> Void {
        self.applyGradient(colors, locations: nil)
    }
    
    func applyGradient(_ colors: [UIColor], locations: [NSNumber]?) -> Void {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
extension UIViewController {
    struct Colors {
        static let customGray = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0)
        static let customDarkGray = UIColor(red:0.60, green:0.62, blue:0.68, alpha:1.0)
    }
}
