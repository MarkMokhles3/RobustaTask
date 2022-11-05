//
//  UIView+Extension.swift
//  RobustaTask
//
//  Created by Mark Mokhles on 05/11/2022.
//

import UIKit

extension UIView {

    func setShadow(color: UIColor = .lightGray, offset: CGSize = CGSize(width: 1, height: 2.5), radius: CGFloat = 4, opacity: Float = 0.15,masksToBounds: Bool = false) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shouldRasterize = true
        layer.masksToBounds = masksToBounds
        layer.rasterizationScale = UIScreen.main.scale
    }

    func setCornerRadius(radius: CGFloat = 5, isClipped: Bool = false, isRounded: Bool = false) {
        if isRounded {
            layer.cornerRadius = self.frame.height / 2
        } else {
            layer.cornerRadius = radius
        }
        layer.masksToBounds = isClipped
    }

    func setRoundCorners(corners: CACornerMask, radius: CGFloat = 5) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
}
