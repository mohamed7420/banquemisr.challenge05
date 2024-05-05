//
//  NSObject+Extension.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import Foundation

public extension NSObject {
    var className: String {
        String(describing: type(of: self))
    }

    class var className: String {
        String(describing: self)
    }
}
