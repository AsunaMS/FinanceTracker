//
//  UIExtensions.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 08/02/2021.
//

import UIKit

extension UIImageView {
    // round's a UIImageView with borderColor and corner radius
    func roundedImage(borderColor: CGColor, cornerRadius: CGFloat) {
        contentMode = .scaleAspectFill
        sizeToFit()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1.0
        clipsToBounds = true
        layer.masksToBounds = true
        layer.borderColor = borderColor
    }
}
