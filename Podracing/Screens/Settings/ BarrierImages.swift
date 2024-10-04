//
//   BarrierImages.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/12/24.
//

import Foundation
import UIKit

final class  BarrierImages {
    static let shared =  BarrierImages()
    
    let barrierArray: [UIImage]

    private init?() {
        guard let image1 = UIImage(named: "stoneOne"),
              let image2 = UIImage(named: "stoneTwo") else {
            return nil
        }
        
        self.barrierArray = [image1, image2, ]
    }
}
