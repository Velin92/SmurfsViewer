import UIKit

class HomeViewController: UIViewController {
    let backgroundImageView = UIImageView()
    let lbTitle = UILabel()
    let lbDate = UILabel()
    let btnOpenViewer = UIButton()
    let baconIpsumView = BaconImpsumView()
    
    struct Constants {
        struct ImageNames {
            static let backgroundImage = "HomeBackground"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        navigationItem.title = "Smurf Viewer"
        //Background image
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: Constants.ImageNames.backgroundImage)
        view.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //Bacon Ipsum label - Demonstration of network service :)
      
        baconIpsumView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(baconIpsumView)
        
        NSLayoutConstraint.activate([
            baconIpsumView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baconIpsumView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baconIpsumView.topAnchor.constraint(equalTo: view.topAnchor),
            baconIpsumView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //Label
        
        lbTitle.translatesAutoresizingMaskIntoConstraints = false
        lbTitle.text = "View all of your favourite smurfs! \nAnd shake your device for a little fun, and quite easy to discover easter egg ;)"
        lbTitle.textAlignment = .center
        lbTitle.numberOfLines = 0
        lbTitle.font = .systemFont(ofSize: 14, weight: .semibold)
        view.addSubview(lbTitle)
        
        NSLayoutConstraint.activate([
            lbTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            lbTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        //Date label
        
        lbDate.translatesAutoresizingMaskIntoConstraints = false
        lbDate.text = "Device date is: \(Injected.dateService.format(Injected.dateService.currentDate, style: .longDate, timeZone: .device))"
        lbDate.font = .systemFont(ofSize: 12, weight: .bold)
        view.addSubview(lbDate)
        
        NSLayoutConstraint.activate([
            lbDate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbDate.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 10)
        ])
        
        //Button
        btnOpenViewer.addTarget(self, action: #selector(openViewerButtonTapped), for: .touchUpInside)
        btnOpenViewer.translatesAutoresizingMaskIntoConstraints = false
        btnOpenViewer.setTitle("Begin", for: .normal)
        btnOpenViewer.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        btnOpenViewer.setTitleColor(.white, for: .normal)
        btnOpenViewer.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        view.addSubview(btnOpenViewer)
        
        NSLayoutConstraint.activate([
            btnOpenViewer.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            btnOpenViewer.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            btnOpenViewer.heightAnchor.constraint(equalToConstant: 50),
            btnOpenViewer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
    }

    
    @objc func openViewerButtonTapped() {
        let smurfViewController = SmurfViewController()
        navigationController?.pushViewController(smurfViewController, animated: true)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        
        beadlesAbout()
    }
}

