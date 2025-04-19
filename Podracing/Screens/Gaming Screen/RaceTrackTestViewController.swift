import UIKit
import SnapKit

class RaceTrackTestViewController: UIViewController {

    private var displayLink: CADisplayLink?
    private var speed: CGFloat = 2.0

    private let trackImages: [UIImageView] = (0..<3).map { _ in
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.track)
        return imageView
    }

    private let upButton = UIButton(type: .system)
    private let downButton = UIButton(type: .system)
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       // startTrackAnimation()
       // animateCountdown(number: 3)
    }

    private func setupUI() {
        for track in trackImages {
            view.addSubview(track)
        }

        view.addSubview(upButton)
//        view.addSubview(downButton)

        // Расстановка кнопок
        upButton.setTitle("UP", for: .normal)
        upButton.backgroundColor = .systemPink
        upButton.addTarget(self, action: #selector(increaseSpeed), for: .touchUpInside)

        downButton.setTitle("Down", for: .normal)
        downButton.backgroundColor = .systemPink
        downButton.addTarget(self, action: #selector(decreaseSpeed), for: .touchUpInside)

        upButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-300)
        }

//        downButton.snp.makeConstraints { make in
//            make.top.equalTo(upButton.snp.bottom).offset(16)
//            make.centerX.equalToSuperview()
//        }

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
        self.animateCountdown(number: 3)
    }

    @objc private func decreaseSpeed() {
        displayLink?.isPaused = false
    }
    
    private func countdownAnimation() {
        var countdownNumber = 3
        let countdownLabel = UILabel()
        countdownLabel.text = "\(countdownNumber)"
        countdownLabel.font = UIFont(name: Font.fontName, size: 10)
       // countdownLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        view.addSubview(countdownLabel)
        
        countdownLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        UIView.animate(withDuration: 1, animations: {
            countdownLabel.alpha = 0
            countdownLabel.transform = CGAffineTransform.init(scaleX: 20, y: 20)
        }) {_ in 
            UIView.animate(withDuration: 1) {
                
                countdownLabel.alpha = 1
                countdownLabel.text = "\(countdownNumber - 1)"
                countdownLabel.alpha = 0
                countdownLabel.transform = CGAffineTransform.init(scaleX: 20, y: 20)
            } completion: { _ in
                countdownNumber -= 1
                countdownLabel.alpha = 0
                countdownLabel.transform = CGAffineTransform.init(scaleX: 20, y: 20)
            }

        }
        
    }
    
    func animateCountdown(number: Int) {
        
        
        let countdownLabel = UILabel()
        countdownLabel.text = "\(number)"
        countdownLabel.font = UIFont(name: Font.fontName, size: 10)
        countdownLabel.text = "\(number)"
        countdownLabel.alpha = 1
        countdownLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        view.addSubview(countdownLabel)
        
        countdownLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        UIView.animate(withDuration: 1, animations: {
            countdownLabel.alpha = 0
            countdownLabel.transform = CGAffineTransform(scaleX: 20, y: 20)
        }) { _ in
            countdownLabel.removeFromSuperview()
            if number > 1 {
                
            } else {
                countdownLabel.text = "go"
                countdownLabel.alpha = 1
                countdownLabel.transform = CGAffineTransform(scaleX: 2, y: 2)

                UIView.animate(withDuration: 1, animations: {
                    countdownLabel.alpha = 0
                    countdownLabel.transform = CGAffineTransform(scaleX: 20, y: 20)
                }) { _ in
                    print("hello")
                }
            }
        }
        
    }
}
