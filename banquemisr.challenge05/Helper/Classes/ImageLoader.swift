//
//  ImageLoader.swift
//  banquemisr.challenge05
//
//  Created by Mohamed Osama on 05/05/2024.
//

import Foundation
import UIKit

class ImageLoader {
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil, let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }

                completion(image)
            }
        }
        task.resume()
    }
}
