import UIKit

class SmurfViewController: UIViewController {
    let lbTitle = UILabel()
    let lbDescription = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        navigationItem.title = ""

        //Title Label

        lbTitle.translatesAutoresizingMaskIntoConstraints = false
        lbTitle.text = "Over to you!"
        lbTitle.textColor = .black
        lbTitle.font = .systemFont(ofSize: 24, weight: .semibold)
        view.addSubview(lbTitle)

        NSLayoutConstraint.activate([
            lbTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15)
        ])

        //Description Label

        lbDescription.translatesAutoresizingMaskIntoConstraints = false
        lbDescription.numberOfLines = 0
        lbDescription.text = "Your objective is to list all the Smurfs found in the smurfs.payload json.\n\nPlease implement this view as you see fit, paying close attention to the project requirements document.\n\nBear in mind that Smurfs can only be truly happy when they know that the key components of their app are unit tested. Look at DateServiceTests.swift (written by Papa Smurf himself) for inspiration if you're stuck.\n\nGood luck!!"
        lbDescription.font = .systemFont(ofSize: 14, weight: .semibold)
        lbDescription.textColor = .black
        view.addSubview(lbDescription)

        NSLayoutConstraint.activate([
            lbDescription.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            lbDescription.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            lbDescription.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 30)
        ])
    }
}
