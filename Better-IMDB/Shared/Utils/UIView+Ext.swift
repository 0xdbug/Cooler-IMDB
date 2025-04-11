//
//  UIView+Ext.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit

// https://gist.github.com/maxcampolo/f893ae8c323b918ce1749390df818503
extension UIView {
    
    /**
     Set a shadow on a UIView.
     - parameters:
     - color: Shadow color, defaults to black
     - opacity: Shadow opacity, defaults to 1.0
     - offset: Shadow offset, defaults to zero
     - radius: Shadow radius, defaults to 0
     - viewCornerRadius: If the UIView has a corner radius this must be set to match
     */
    func setShadowWithColor(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius ?? 0.0).CGPath
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
    }
}
