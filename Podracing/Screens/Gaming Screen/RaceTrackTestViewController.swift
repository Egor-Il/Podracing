import UIKit
import SnapKit

class RaceTrackTestViewController: UIViewController {

    private var displayLink: CADisplayLink?
    private var speed: CGFloat = 2.0

    private let trackImages: [UIImageView] = (0..<3).map { _ in
        let imageView = UIImageView()
        imageView.image = UIImage(named: "trackWithCurb")
        return imageView
    }

    private let upButton = UIButton(type: .system)
    private let downButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startTrackAnimation()
    }

    private func setupUI() {
        for track in trackImages {
            view.addSubview(track)
        }

        view.addSubview(upButton)
        view.addSubview(downButton)

        // Расстановка кнопок
        upButton.setTitle("UP", for: .normal)
        upButton.backgroundColor = .systemPink
        upButton.addTarget(self, action: #selector(increaseSpeed), for: .touchUpInside)

        downButton.setTitle("Down", for: .normal)
        downButton.backgroundColor = .systemPink
        downButton.addTarget(self, action: #selector(decreaseSpeed), for: .touchUpInside)

        upButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        downButton.snp.makeConstraints { make in
            make.top.equalTo(upButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        // Изначальная расстановка треков
        for (index, track) in trackImages.enumerated() {
            track.frame = CGRect(x: 0,
                                 y: -view.frame.height * CGFloat(index),
                                 width: view.frame.width,
                                 height: view.frame.height)
        }
    }

    private func startTrackAnimation() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateTracks))
        displayLink?.add(to: .main, forMode: .common)
    }

    @objc private func updateTracks() {
        for track in trackImages {
            track.frame.origin.y += speed
        }

        for track in trackImages {
            if track.frame.origin.y >= view.frame.height {
                if let topY = trackImages.map({ $0.frame.origin.y }).min() {
                    track.frame.origin.y = topY - view.frame.height
                }
            }
        }
    }

    @objc private func increaseSpeed() {
        speed += 1
    }

    @objc private func decreaseSpeed() {
        speed = max(1, speed - 1)
    }
}
