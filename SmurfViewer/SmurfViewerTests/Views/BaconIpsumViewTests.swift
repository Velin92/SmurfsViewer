import Foundation
@testable import SmurfViewer
import XCTest

class BaconIpsumViewTests: UnitTestCase {
    var window: UIWindow!
    var hostVC: UIViewController!
    var sut: BaconImpsumView!
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
        hostVC = UIViewController(nibName: nil, bundle: nil)
        window.rootViewController = hostVC
    }

    func createAndAddView() {
        sut = BaconImpsumView()
        hostVC.view.addSubview(sut)
        sut.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
    }

    func test_dataIsRetrievedFromNetworkService_thenStringIsDisplayedInView() {
        let expectedString = "DummyBaconData"
        mockNetworkService.returnResult = .success(
            .init(
                urlResponse: HTTPURLResponse(url: URL(string: "http://www.dummy.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil),
                data: expectedString.data(using: .utf8)!
            )
        )
        let labelExpectation = expectation(description: "Label text is set")
        
        createAndAddView()
        delayedCall {
            labelExpectation.fulfill()
            XCTAssertEqual(self.sut.lbBaconIpsum.text, expectedString)
        }

        wait(for: [labelExpectation], timeout: 3)
    }

    func test_errorIsReturnedByNetworkService_thenErrorIsDisplayedInView() {
        let expectedString = "Sorry an error occured"
        mockNetworkService.returnResult = .failure(NSError(domain: "", code: 1, userInfo: [:]))
        let labelExpectation = expectation(description: "Label text is set to error message")
        
        createAndAddView()
        delayedCall {
            labelExpectation.fulfill()
            XCTAssertEqual(self.sut.lbBaconIpsum.text, expectedString)
        }

        wait(for: [labelExpectation], timeout: 3)
    }
}
