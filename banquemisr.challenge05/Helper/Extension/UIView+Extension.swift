//
//  UIView+Extension.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import UIKit

public extension UIView {
    /// loads a full view from a xib file
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIView>() -> T {
            UINib(nibName: "\(T.self)", bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
        }
        return instantiateFromNib()
    }
}
