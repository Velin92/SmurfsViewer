/*
 The following demonstrates how to use the Injected network service
 */
import UIKit

class BaconImpsumView: UIView {
    let lbBaconIpsum = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        //Bacon Ipsum label - Demonstration of network service :)
        lbBaconIpsum.text = "🐖 Loading swine ipsum 🐖"
        lbBaconIpsum.font = .systemFont(ofSize: 20, weight: .semibold)
        lbBaconIpsum.textColor = UIColor.black.withAlphaComponent(0.03)
        lbBaconIpsum.translatesAutoresizingMaskIntoConstraints = false
        lbBaconIpsum.numberOfLines = 0
        addSubview(lbBaconIpsum)
        
        NSLayoutConstraint.activate([
            lbBaconIpsum.leadingAnchor.constraint(equalTo: leadingAnchor),
            lbBaconIpsum.trailingAnchor.constraint(equalTo: trailingAnchor),
            lbBaconIpsum.topAnchor.constraint(equalTo: topAnchor),
            lbBaconIpsum.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        refresh()
    }
    
    func refresh() {
        let request = URLRequest(url: URL(string: "https://baconipsum.com/api/?type=meat-and-filler&paras=5&format=text")!)
        Injected.networkService.data(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.lbBaconIpsum.text = response.utf8Value
            case .failure(let error):
                print("Whoops! An error occured - \(error)")
                self.lbBaconIpsum.text = "Sorry an error occured"
            }
        }
    }
}
