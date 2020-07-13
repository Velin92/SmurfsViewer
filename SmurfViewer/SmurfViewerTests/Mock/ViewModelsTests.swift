//
//  ViewModelsTests.swift
//  SmurfViewerTests
//
//  Created by Mauro Romito on 13/07/2020.
//  Copyright © 2020 Bofin Ltd. All rights reserved.
//

import Foundation
@testable import SmurfViewer
import XCTest

class ViewModelsTests: UnitTestCase {
    
    func test_SmurfsListViewModelSuccess() {
        let viewModel = SmurfsListViewModel()
        viewModel.networkService = MockedSmurfNetworkService(testType: .success)
        viewModel.fetchSmurfData()
        let expectation = XCTestExpectation()
        //published variables need to be tested with expectations
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.cellViewModels.count, 2)
            XCTAssertEqual(viewModel.cellViewModels[0].name, "A")
            XCTAssertEqual(viewModel.cellViewModels[1].name, "B")
            XCTAssertEqual(viewModel.exceptionState, .none)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_SmurfsListViewModelSuccessButEmptyNames() {
        let viewModel = SmurfsListViewModel()
        viewModel.networkService = MockedSmurfNetworkService(testType: .successButEmptyNames)
        viewModel.fetchSmurfData()
        let expectation = XCTestExpectation()
        //published variables need to be tested with expectations
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.cellViewModels.count, 0)
            XCTAssertEqual(viewModel.exceptionState, .empty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_SmurfsListViewModelFailure() {
        let viewModel = SmurfsListViewModel()
        viewModel.networkService = MockedSmurfNetworkService(testType: .failure)
        viewModel.fetchSmurfData()
        let expectation = XCTestExpectation()
        //published variables need to be tested with expectations
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.cellViewModels.count, 0)
            XCTAssertEqual(viewModel.exceptionState, .error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_SmurfsListViewModelEmpty() {
        let viewModel = SmurfsListViewModel()
        viewModel.networkService = MockedSmurfNetworkService(testType: .empty)
        viewModel.fetchSmurfData()
        let expectation = XCTestExpectation()
        //published variables need to be tested with expectations
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.cellViewModels.count, 0)
            XCTAssertEqual(viewModel.exceptionState, .empty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

