import Foundation
import XCTest
@testable import SmurfViewer

class UnitTestCase: XCTestCase {
    var mockDateService: MockDateService!
    var mockNetworkService: MockNetworkService!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        Injected.reset()
        setupMocks()
    }
    
    func setupMocks() {
        if let mock = createMockDateService() {
            mockDateService = mock
            Injected.dateService = mock
        }
        if let mock = createMockNetworkService() {
            mockNetworkService = mock
            Injected.networkService = mock
        }
    }
    
    // MARK: - Subclassing
    
    func createMockDateService() -> MockDateService? {
        return MockDateService()
    }
    func createMockNetworkService() -> MockNetworkService? {
        return MockNetworkService()
    }
}
