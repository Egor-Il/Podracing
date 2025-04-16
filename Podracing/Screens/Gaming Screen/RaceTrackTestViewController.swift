//
//  RaceTrackTestViewController.swift
//  Podracing
//
//  Created by Egor Ilchenko on 4/8/25.
//

import UIKit
import SnapKit

class RaceTrackTestViewController: UIViewController {

    private var track: UIImageView = {
        var trackField = UIImageView()
        let track = UIImage(named: "v5")
        trackField.image = track
        return trackField
    }()
    private var trackTwo: UIImageView = {
        var trackField = UIImageView()
        let track = UIImage(named: "v5")
        trackField.image = track
        return trackField
    }()
    private var trackTree: UIImageView = {
        var trackField = UIImageView()
        let track = UIImage(named: "v5")
        trackField.image = track
        return trackField
    }()

    var trackViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        trackMovementUI()
        trackRace()
        //startInfiniteScroll(speed: 100)
    }

    func trackMovementUI() {
        // Устанавливаем начальные позиции для всех треков
        [track, trackTwo, trackTree].forEach {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.width.height.equalToSuperview()
            }
        }

        track.snp.makeConstraints { make in
            make.top.equalToSuperview()  // Трек начнется с верхней части экрана
            make.left.right.equalToSuperview()
        }
        trackTwo.snp.makeConstraints { make in
            make.top.equalTo(track.snp.bottom)  // Второй трек будет под первым
        }
        trackTree.snp.makeConstraints { make in
            make.top.equalTo(trackTwo.snp.bottom)  // Третий трек под вторым
        }

        trackViews = [track, trackTwo, trackTree]
    }

    func trackRace() {
        // Плавно анимируем трек вниз
        UIView.animate(withDuration: 8, delay: 0.01, options: [.curveLinear]) {
            // Увеличиваем y-координату, чтобы трек двигался вниз
            self.track.frame.origin.y += self.view.frame.height
        }
    }
}
