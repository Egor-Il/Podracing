//
//  PodImages.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/11/24.
//

import UIKit

struct PodImage {
    let name: String
    let image: UIImage
}

final class PodImages {
    static let shared = PodImages()
    
    let podArray: [PodImage]
    
    private init() {
        let names = ["mainPod", "podTwo", "podThree"]
        self.podArray = names.compactMap { name in
            guard let image = UIImage(named: name) else { return nil }
            return PodImage(name: name, image: image)
        }
    }
}
