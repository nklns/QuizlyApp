//
//  UIView+AddSubviews.swift
//  QuizApp
//
//  Created by Станислав Никулин on 09.10.2024.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
