//
//  PodImages.swift
//  Podracing
//
//  Created by Egor Ilchenko on 6/11/24.
//

import Foundation
import UIKit

final class PodImages {
    static let shared = PodImages()
    
    let podArray: [UIImage]
    
    private init?() {
        guard let image1 = UIImage(named: "mainPod"),
              let image2 = UIImage(named: "podTwo"),
              let image3 = UIImage(named: "podThree") else {
            return nil
        }
        self.podArray = [image1, image2, image3, ]
    }
}
