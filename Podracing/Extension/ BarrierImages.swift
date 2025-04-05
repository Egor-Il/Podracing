//
//   BarrierImages.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/12/24.
//

import UIKit

struct BarrierImage {
    let name: String
    let image: UIImage
}

final class BarrierImages {
    static let shared = BarrierImages()
    
    let barrierArray: [BarrierImage]
    
    private init() {
        let names = ["stoneOne", "stoneTwo"]
        self.barrierArray = names.compactMap { name in
            guard let image = UIImage(named: name) else { return nil }
            return BarrierImage(name: name, image: image)
        }
    }
}

