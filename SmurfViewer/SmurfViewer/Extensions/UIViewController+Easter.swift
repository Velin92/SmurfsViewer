/*
* Copyright 2020 Jokey Smurf
*/

import UIKit

extension UIViewController {
    
    func beadlesAbout() {
        let images = [UIImage(named: "Beadle")!, UIImage(named: "Beadle2")]
        guard let image = images.randomElement() else {
            return
        }
        
        let easterImageView = UIImageView()
        easterImageView.image = image
        easterImageView.contentMode = .scaleAspectFill
        view.addSubview(easterImageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        let easterSize = CGSize(width: CGFloat.random(in: 30...70), height:  CGFloat.random(in: 30...70))
        easterImageView.frame = CGRect(x: CGFloat.random(in: 0...view.bounds.width - easterImageView.bounds.width), y: 0, width: easterSize.width, height: easterSize.height)

        UIView.animate(withDuration: 1, animations: {
            var frame = easterImageView.frame
            frame.origin.y = self.view.bounds.maxY + 100
            easterImageView.frame = frame
        }) { _ in
            easterImageView.removeFromSuperview()
        }
    }
}
