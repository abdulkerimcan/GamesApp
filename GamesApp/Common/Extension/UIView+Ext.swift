//
//  UIView+Ext.swift
//  GamesApp
//
//  Created by Abdulkerim Can on 5.03.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
